#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Opens DB Browser for SQLite on a database, selects a table in the
# "Browse Data" tab and captures the window.
#
# Usage: dbbrowser_capture.sh <database> <table-downs> <output.png> [wait]
#   <table-downs> = number of Down presses needed to reach the table in the
#                   "Table:" combo box (moz_places = 14)
# ---------------------------------------------------------------------------
set -uo pipefail

DB="$1"; DOWNS="$2"; OUT="$3"; WAIT="${4:-8}"
DISPLAY="${DISPLAY:-:0}"
export DISPLAY
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$HERE")"
export PATH="$ROOT/tools/bin:$PATH"

LOG="$(mktemp /tmp/dbb.XXXXXX.log)"
APP_PID=""
WID=""
cleanup() {
    [ -n "$APP_PID" ] && kill "$APP_PID" 2>/dev/null || true
    rm -f "$LOG"
}
trap cleanup EXIT

sqlitebrowser "$DB" >"$LOG" 2>&1 &
APP_PID=$!

for _ in $(seq 1 80); do
    sleep 0.25
    for id in $(xprop -root _NET_CLIENT_LIST 2>/dev/null | grep -o '0x[0-9a-f]*'); do
        pid=$(xprop -id "$id" _NET_WM_PID 2>/dev/null | grep -o '[0-9]\+' | head -1)
        if [ -n "$pid" ] && [ "$pid" = "$APP_PID" ]; then
            WID="$id"
            break
        fi
    done
    [ -n "$WID" ] && break
done
[ -n "$WID" ] || { echo "no window" >&2; cat "$LOG" >&2; exit 1; }

sleep "$WAIT"
xdotool windowraise "$WID" 2>/dev/null || true
sleep 0.5

xdotool mousemove --window "$WID" 170 68 click 1    # "Browse Data" tab
sleep 2
xdotool mousemove --window "$WID" 235 97 click 1    # "Table:" combo box
sleep 1.5
for _ in $(seq 1 "$DOWNS"); do
    xdotool key --window "$WID" Down
    sleep 0.15
done
xdotool key --window "$WID" Return
sleep 2.5

import -window "$WID" "$OUT" 2>/dev/null
echo "captured -> $OUT"
