#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Screenshot harness.
#
# Runs a list of shell commands inside a *real* terminal window (st) on the
# live X display, waits for them to finish, captures only that window and
# crops the image down to the printed content.
#
# The window is located by the PID of the st process (_NET_WM_PID), so no
# other window on the desktop is ever captured.
#
# Usage: capture.sh <output.png> <commands-file> [workdir] [timeout-secs]
# ---------------------------------------------------------------------------
set -euo pipefail

OUT="$1"
CMDS="$2"
WORKDIR="${3:-$PWD}"
TIMEOUT="${4:-180}"
DISPLAY="${DISPLAY:-:0}"
export DISPLAY

RUNNER="$(mktemp /tmp/cap_runner.XXXXXX.sh)"
DONE="$(mktemp /tmp/cap_done.XXXXXX)"
ST_LOG="$(mktemp /tmp/cap_st.XXXXXX.log)"
ST_PID=""
WID=""

cleanup() {
    [ -n "$ST_PID" ] && kill "$ST_PID" 2>/dev/null || true
    rm -f "$RUNNER" "$DONE" "$ST_LOG"
}
trap cleanup EXIT

# The runner gets its parameters baked in: `st -e` argument passing is not
# reliable across st builds, so the script is generated instead.
cat >"$RUNNER" <<RUNNER_EOF
#!/usr/bin/env bash
CMDS='$CMDS'
DONE='$DONE'
WORKDIR='$WORKDIR'
cd "\$WORKDIR" || exit 1

BLOCK=""
IN_BLOCK=0
PENDING=""
run_block() {
    printf '\\033[1;32muser@arch\\033[0m:\\033[1;34m%s\\033[0m\$ %s\n' "\$PWD" "\$(echo "\$BLOCK" | head -1)"
    eval "\$BLOCK" 2>&1
    printf '\\033[0m'
    BLOCK=""
}

while IFS= read -r line; do
    # join lines that end with a backslash (shell line continuation)
    if [ -n "\$PENDING" ]; then
        line="\$PENDING\$line"
        PENDING=""
    fi
    case "\$line" in
        *\\\\) PENDING="\${line%\\\\} "; continue ;;
    esac

    case "\$line" in
        '### BLOCK') BLOCK=""; IN_BLOCK=1; continue ;;
        '### ENDBLOCK') run_block; IN_BLOCK=0; continue ;;
        '#'*) printf '\\033[2;37m%s\\033[0m\n' "\$line"; continue ;;
        '') [ "\$IN_BLOCK" = "1" ] && BLOCK="\$BLOCK\$line
"; continue ;;
        *)
            if [ "\$IN_BLOCK" = "1" ]; then
                BLOCK="\$BLOCK\$line
"
            else
                printf '\\033[1;32muser@arch\\033[0m:\\033[1;34m%s\\033[0m\$ %s\n' "\$PWD" "\$line"
                eval "\$line" 2>&1
                printf '\\033[0m'
            fi
            ;;
    esac
done <"\$CMDS"
: >"\$DONE"
sleep 600
RUNNER_EOF
chmod +x "$RUNNER"

# 1. Launch the terminal window.
st -f "JetBrains Mono:size=11" -e bash "$RUNNER" >"$ST_LOG" 2>&1 &
ST_PID=$!

# 2. Find the window that belongs to that st process.
for _ in $(seq 1 80); do
    sleep 0.25
    for id in $(xprop -root _NET_CLIENT_LIST 2>/dev/null | grep -o '0x[0-9a-f]*'); do
        pid=$(xprop -id "$id" _NET_WM_PID 2>/dev/null | grep -o '[0-9]\+' | head -1)
        if [ -n "$pid" ] && [ "$pid" = "$ST_PID" ]; then
            WID="$id"
            break
        fi
    done
    [ -n "$WID" ] && break
done

if [ -z "$WID" ]; then
    echo "capture.sh: could not locate the terminal window" >&2
    cat "$ST_LOG" >&2
    exit 1
fi

# 3. Wait for the commands to finish (bounded).
waited=0
while [ ! -e "$DONE" ]; do
    sleep 1
    waited=$((waited + 1))
    if [ "$waited" -ge "$TIMEOUT" ]; then
        echo "capture.sh: warning - commands did not finish within ${TIMEOUT}s" >&2
        break
    fi
done
sleep 1.5

# 4. Raise the window so nothing else overlaps the capture.
xdotool windowraise "$WID" 2>/dev/null || true
sleep 0.5

# 5. Capture that window only, then trim to the printed content.
import -window "$WID" "$OUT" 2>/dev/null
magick "$OUT" -trim +repage -bordercolor '#1c1c28' -border 14 "$OUT"

echo "captured -> $OUT"
