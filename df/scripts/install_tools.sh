#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Rootless installer for the digital-forensics lab tools.
#
# `pacman -S` needs root, so this script resolves every package (and its
# missing dependencies) with `pacman -Sp`, downloads the .pkg.tar.zst files
# and unpacks them into ./tools (a self-contained prefix).
#
# Usage:  ./scripts/install_tools.sh <package> [package ...]
# Then:   export PATH="$PWD/tools/usr/bin:$PATH"
#          export LD_LIBRARY_PATH="$PWD/tools/usr/lib:$LD_LIBRARY_PATH"
#          export PERL5LIB="$PWD/tools/usr/share/perl5/vendor_perl:$PERL5LIB"
# ---------------------------------------------------------------------------
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$HERE")"
PREFIX="$ROOT/tools"
CACHE="$PREFIX/.cache"

mkdir -p "$PREFIX" "$CACHE"
cd "$CACHE"

log() { printf '\033[1;34m[install]\033[0m %s\n' "$*"; }

# 1. Full recursive dependency closure of the requested packages.
log "resolving dependency closure..."
closure=$(python3 "$HERE/pacman_resolve.py" "$@" || true)

# 2. Which of those are already on the system?
installed=$(pacman -Q 2>/dev/null | awk '{print $1}' | sort -u || true)

missing=()
while read -r p; do
    [ -z "$p" ] && continue
    if ! grep -qxF "$p" <<<"$installed"; then
        missing+=("$p")
    fi
done <<<"$closure"

log "need ${#missing[@]} package(s) not present on the system"
printf '  %s\n' "${missing[@]}" | sed 's/^/    - /'

# 3. Download each missing package.
for p in "${missing[@]}"; do
    url=$(pacman -Sp --print-format '%l' "$p" 2>/dev/null | tail -1)
    [ -z "$url" ] && { log "SKIP $p (no url found)"; continue; }
    file="$(basename "$url")"
    if [ ! -f "$file" ] || ! bsdtar -tf "$file" >/dev/null 2>&1; then
        log "downloading $p"
        curl -sSL --retry 3 -o "$file" "$url" || rm -f "$file"
        # the current mirrors may have dropped the package already -> use the archive
        if [ ! -f "$file" ] || ! bsdtar -tf "$file" >/dev/null 2>&1; then
            arch="https://archive.archlinux.org/packages/${file:0:1}/$p/$file"
            log "  mirror failed, trying the archive: $arch"
            curl -sSL --retry 3 -o "$file" "$arch" || rm -f "$file"
        fi
    fi
done

# 4. Unpack everything into the prefix.
log "unpacking into $PREFIX"
for f in *.pkg.tar.zst; do
    [ -f "$f" ] || continue
    bsdtar -xf "$f" -C "$PREFIX"
done

# 5. Make the binaries runnable without touching LD_LIBRARY_PATH everywhere.
mkdir -p "$PREFIX/bin"
for exe in "$PREFIX/usr/bin"/* "$PREFIX/usr/bin/vendor_perl"/*; do
    [ -f "$exe" ] || continue
    name="$(basename "$exe")"
    [ -e "$PREFIX/bin/$name" ] && continue
    cat >"$PREFIX/bin/$name" <<EOF
#!/usr/bin/env bash
export LD_LIBRARY_PATH="$PREFIX/usr/lib:\${LD_LIBRARY_PATH:-}"
export PERL5LIB="$PREFIX/usr/share/perl5/vendor_perl:\${PERL5LIB:-}"
exec "$exe" "\$@"
EOF
    chmod +x "$PREFIX/bin/$name"
done

log "done. Add to PATH:  export PATH=\"$PREFIX/bin:\$PATH\""
