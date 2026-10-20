#!/usr/bin/env bash
# Prints the inventory of forensic tools available in this lab.
export PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/tools/bin:$PATH"

printf '%-14s %-46s %s\n' "TOOL" "VERSION" "FORENSIC PURPOSE"
printf '%-14s %-46s %s\n' "--------------" "----------------------------------------------" "-----------------------------"
printf '%-14s %-46s %s\n' "fls/istat/icat" "$(fls -V 2>&1 | head -1)" "list / stat / extract files by inode"
printf '%-14s %-46s %s\n' "tsk_recover" "$(tsk_recover -V 2>&1 | head -1)" "bulk recovery of deleted files"
printf '%-14s %-46s %s\n' "mactime" "$(mactime -V 2>&1 | head -1)" "body-file timeline generation"
printf '%-14s %-46s %s\n' "photorec" "$(photorec /version 2>&1 | grep '^Version')" "signature based file carving"
printf '%-14s %-46s %s\n' "exiftool" "v$(exiftool -ver)" "image / document metadata extraction"
printf '%-14s %-46s %s\n' "mcopy/mdir" "$(mcopy -V 2>&1 | head -1)" "read-write FAT image without mounting"
printf '%-14s %-46s %s\n' "dcfldd" "1.9.3 (AUR, built from source)" "dd replacement that hashes while copying"
printf '%-14s %-46s %s\n' "sqlite3" "$(sqlite3 --version | cut -d' ' -f1)" "read browser history databases"
printf '%-14s %-46s %s\n' "sqlitebrowser" "3.13.1" "GUI viewer for SQLite databases"
printf '%-14s %-46s %s\n' "journalctl" "$(journalctl --version | head -1)" "systemd boot / service timeline"
printf '%-14s %-46s %s\n' "volatility3" "2.28.2 (python venv)" "volatile memory analysis"
