#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# (Re)generate the launcher wrappers in tools/bin.
#
# Every wrapper sets LD_LIBRARY_PATH / PERL5LIB to the local prefix so the
# tools run without a system-wide installation and without root.
# ---------------------------------------------------------------------------
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$HERE")"
PREFIX="$ROOT/tools"

mkdir -p "$PREFIX/bin"

for exe in "$PREFIX/usr/bin"/* "$PREFIX/usr/bin/vendor_perl"/*; do
    [ -f "$exe" ] || continue
    name="$(basename "$exe")"
    cat >"$PREFIX/bin/$name" <<EOF
#!/usr/bin/env bash
export LD_LIBRARY_PATH="$PREFIX/usr/lib:\${LD_LIBRARY_PATH:-}"
export PERL5LIB="$PREFIX/usr/share/perl5/vendor_perl:\${PERL5LIB:-}"
exec "$exe" "\$@"
EOF
    chmod +x "$PREFIX/bin/$name"
done

echo "wrappers refreshed in $PREFIX/bin ($(ls "$PREFIX/bin" | wc -l) entries)"
