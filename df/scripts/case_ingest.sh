#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Live case investigation with The Sleuth Kit.
#
# This performs the same steps as the Autopsy ingest pipeline:
#   1. create the case and add the forensic image as the data source
#   2. record the hash of the data source (Hash Lookup module)
#   3. build the file system database and extract the files (File Extraction)
#   4. identify the file types (File Type Identification module)
#   5. run a keyword search over the extracted content (Keyword Search module)
#   6. build the activity timeline (Recent Activity module)
#   7. write the case report
#
# Usage: case_ingest.sh <case-dir> <image-file>
# ---------------------------------------------------------------------------
set -uo pipefail

CASE="$1"
IMAGE="$2"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$HERE")"
export PATH="$ROOT/tools/bin:$PATH"

mkdir -p "$CASE"/{evidence,export,reports,logs}
cp -f "$IMAGE" "$CASE/evidence/$(basename "$IMAGE")"

echo "=============================================================="
echo " CASE DF-2026-014 : live investigation"
echo " case directory   : $CASE"
echo " operator         : $(whoami)@$(cat /etc/hostname 2>/dev/null || echo unknown)"
echo " date             : $(date)"
echo "=============================================================="

# --- 1. data source: hash the image (Hash Lookup ingest module) -------------
echo
echo "--- [1] data source added to the case ---"
DATA="$CASE/evidence/$(basename "$IMAGE")"
ls -l "$DATA"
sha256sum "$DATA" | tee "$CASE/logs/data_source.sha256"
echo "hash stored in    : $CASE/logs/data_source.sha256"

# --- 2. build the file system database (File Extraction module) -------------
echo
echo "--- [2] building the file system database ---"
rm -f "$CASE/export/tsk.db"
tsk_loaddb -d "$CASE/export/tsk.db" "$DATA" 2>&1 | tail -3
sqlite3 "$CASE/export/tsk.db" ".tables"
sqlite3 "$CASE/export/tsk.db" "SELECT COUNT(*) || ' file system objects written to the case database' FROM tsk_files;"
sqlite3 "$CASE/export/tsk.db" "SELECT type || ' : ' || COUNT(*) FROM tsk_files GROUP BY type ORDER BY COUNT(*) DESC;"

# --- 3. extract the files ---------------------------------------------------
echo
echo "--- [3] extracting the files (tsk_recover) ---"
tsk_recover -e -f fat32 "$DATA" "$CASE/export/recovered/" > "$CASE/logs/recover.log" 2>&1
find "$CASE/export/recovered" -type f | wc -l | xargs echo "files recovered:"

# --- 4. file type identification -------------------------------------------
echo
echo "--- [4] file type identification ---"
find "$CASE/export/recovered" -type f -exec file -b {} \; | sort | uniq -c | sort -rn | head -8

# --- 5. keyword search ------------------------------------------------------
echo
echo "--- [5] keyword search over the recovered content ---"
for kw in "Talegaon" "DF-2026-014" "protonmail" "USBDrive"; do
    n=$(grep -ril "$kw" "$CASE/export/recovered" 2>/dev/null | wc -l)
    printf 'keyword %-14s : %s hit(s)\n' "$kw" "$n"
done
echo
echo "matches for 'Talegaon':"
grep -ril "Talegaon" "$CASE/export/recovered" 2>/dev/null | head -5

# --- 6. activity timeline (Recent Activity module) --------------------------
echo
echo "--- [6] building the activity timeline (mactime) ---"
fls -r -m "$CASE/export" -f fat32 "$DATA" > "$CASE/export/bodyfile_raw.txt" 2>/dev/null
# mactime reads unix epoch seconds from the body file, but rejects a row that
# carries a zero (unset) timestamp - the FAT creation time is 0, so it is
# replaced by the modification time of the same file.
awk -F'|' 'BEGIN{OFS="|"} {
    if ($8 == 0) $8 = $9
    if ($10 == 0) $10 = $9
    print
}' "$CASE/export/bodyfile_raw.txt" > "$CASE/export/bodyfile.txt"
mactime -b "$CASE/export/bodyfile.txt" -d > "$CASE/export/timeline.csv" 2>"$CASE/logs/mactime.log"
echo "timeline entries : $(wc -l < "$CASE/export/timeline.csv")"
head -6 "$CASE/export/timeline.csv"

# --- 7. case report ---------------------------------------------------------
echo
echo "--- [7] writing the case report ---"
REPORT="$CASE/reports/case_report.html"
{
    echo "<!DOCTYPE html><html><head><meta charset='utf-8'>"
    echo "<title>Case DF-2026-014 - report</title>"
    echo "<style>body{font-family:DejaVu Sans,Arial;margin:32px;background:#0f1115;color:#e6e6e6}"
    echo "h1,h2{color:#7cc4ff}table{border-collapse:collapse;margin:12px 0}"
    echo "td,th{border:1px solid #333;padding:6px 10px;text-align:left;font-size:14px}"
    echo "th{background:#1b1f27}.ok{color:#7ee787}</style></head><body>"
    echo "<h1>Digital Forensics Case Report</h1>"
    echo "<p><b>Case</b> DF-2026-014 &nbsp;|&nbsp; <b>Operator</b> $(whoami) &nbsp;|&nbsp; <b>Generated</b> $(date -u '+%Y-%m-%d %H:%M:%S UTC')</p>"
    echo "<h2>1. Data source</h2><table><tr><th>Property</th><th>Value</th></tr>"
    echo "<tr><td>Image</td><td>$(basename "$DATA")</td></tr>"
    echo "<tr><td>Size</td><td>$(stat -c%s "$DATA") bytes</td></tr>"
    echo "<tr><td>SHA-256</td><td>$(cut -d' ' -f1 "$CASE/logs/data_source.sha256")</td></tr>"
    echo "</table>"
    echo "<h2>2. File system objects recovered</h2><table><tr><th>Object</th><th>Size</th><th>Last modified</th></tr>"
    sqlite3 "$CASE/export/tsk.db" "SELECT name, size, datetime(mtime,'unixepoch') FROM tsk_files WHERE meta_type = 1 AND name != '' ORDER BY mtime;"
    echo "</table>"
    echo "<h2>3. Keyword search results</h2><table><tr><th>Keyword</th><th>Hits</th></tr>"
    for kw in "Talegaon" "DF-2026-014" "protonmail" "USBDrive"; do
        n=$(grep -ril "$kw" "$CASE/export/recovered" 2>/dev/null | wc -l)
        echo "<tr><td>$kw</td><td>$n</td></tr>"
    done
    echo "</table>"
    echo "<h2>4. Activity timeline (first entries)</h2><table><tr><th>Date</th><th>Type</th><th>File</th></tr>"
    head -12 "$CASE/export/timeline.csv" | awk -F',' '{printf "<tr><td>%s</td><td>%s</td><td>%s</td></tr>\n", $4, $5, $7}'
    echo "</table>"
    echo "<p class='ok'>Report generated by scripts/case_ingest.sh (The Sleuth Kit 4.15.0)</p>"
    echo "</body></html>"
} > "$REPORT"
echo "report written to : $REPORT ($(stat -c%s "$REPORT") bytes)"
