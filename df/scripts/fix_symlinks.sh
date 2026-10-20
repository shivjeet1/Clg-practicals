#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Repairs the absolute symlinks that the Arch packages contain
# (/usr/bin/java -> /usr/lib/jvm/default-runtime/bin/java, ...) so that they
# point into the local prefix ./tools instead of the (missing) system path.
# ---------------------------------------------------------------------------
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$HERE")"
PREFIX="$ROOT/tools"

fixed=0
for l in "$PREFIX/usr/bin"/* "$PREFIX/usr/lib/jvm"/*/bin/* "$PREFIX/usr/lib/jvm"/*/conf "$PREFIX/usr/lib/jvm"/*/legal; do
    [ -L "$l" ] || continue
    [ -e "$l" ] && continue          # symlink already resolves
    target="$(readlink "$l")"
    case "$target" in
        /usr/lib/jvm/*)
            newtarget="$PREFIX$target"
            ln -sfn "$newtarget" "$l"
            echo "fixed: $l -> $newtarget"
            fixed=$((fixed + 1))
            ;;
        /etc/java*|/etc/java-*)
            newtarget="$PREFIX$target"
            ln -sfn "$newtarget" "$l"
            echo "fixed: $l -> $newtarget"
            fixed=$((fixed + 1))
            ;;
        /usr/share/ant/*)
            newtarget="$PREFIX$target"
            ln -sfn "$newtarget" "$l"
            echo "fixed: $l -> $newtarget"
            fixed=$((fixed + 1))
            ;;
    esac
done

# the jvm "default" links point at a version directory
if [ -d "$PREFIX/usr/lib/jvm/default-runtime" ] || [ -L "$PREFIX/usr/lib/jvm/default-runtime" ]; then
    :
fi

echo "$fixed symlink(s) repointed at the local prefix"
