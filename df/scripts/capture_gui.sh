#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Screenshot harness for GUI applications.
#
# Starts an application on the live X display, waits until its window is up,
# captures that window only (matched by _NET_WM_PID) and crops it.
#
# Usage: capture_gui.sh <output.png> <wait-seconds> <command> [args...]
# ---------------------------------------------------------------------------
set -euo pipefail

OUT="$1"; shift
WAIT="$1"; shift
DISPLAY="${DISPLAY:-:0}"
export DISPLAY

ST_LOG="$(mktemp /tmp/cap_gui.XXXXXX.log)"
APP_PID=""
WID=""

cleanup() {
    [ -n "$APP_PID" ] && kill "$APP_PID" 2>/dev/null || true
    rm -f "$ST_LOG"
}
trap cleanup EXIT

"$@" >"$ST_LOG" 2>&1 &
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

if [ -z "$WID" ]; then
    echo "capture_gui.sh: window not found" >&2
    cat "$ST_LOG" >&2
    exit 1
fi

sleep "$WAIT"
xdotool windowraise "$WID" 2>/dev/null || true
sleep 0.6

import -window "$WID" "$OUT" 2>/dev/null
echo "captured -> $OUT"
