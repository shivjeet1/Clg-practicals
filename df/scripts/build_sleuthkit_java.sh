#!/usr/bin/env bash
# Builds the Java bindings of The Sleuth Kit (sleuthkit-java) that Autopsy
# needs, completely outside of the system (no root required).
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PREFIX="$ROOT/tools"
BUILD=/tmp/opencode/tskjava
export PATH="$PREFIX/bin:$PATH"
export LD_LIBRARY_PATH="$PREFIX/usr/lib:${LD_LIBRARY_PATH:-}"
export JAVA_HOME="$PREFIX/usr/lib/jvm/java-17-openjdk"
export ACLOCAL_PATH="/usr/share/aclocal:$PREFIX/usr/share/aclocal"

echo "[1/5] installing ant + swig into the local prefix"
"$ROOT/scripts/install_tools.sh" ant swig autoconf-archive || exit 1
"$ROOT/scripts/make_wrappers.sh" || exit 1

echo "[2/5] fetching the sleuthkit sources"
mkdir -p "$BUILD"
cd "$BUILD"
curl -sL --retry 3 -o sleuthkit.tar.gz \
    "https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-4.15.0/sleuthkit-4.15.0.tar.gz" || exit 1
tar xzf sleuthkit.tar.gz || exit 1
cd sleuthkit-4.15.0 || exit 1

echo "[3/5] configuring with --enable-java"
autoreconf -fi > /tmp/opencode/tskjava_autoreconf.log 2>&1
CFLAGS="-std=gnu17" ./configure --prefix="$PREFIX/usr" --enable-java \
    > /tmp/opencode/tskjava_configure.log 2>&1 || { tail -20 /tmp/opencode/tskjava_configure.log; exit 1; }

echo "[4/5] compiling The Sleuth Kit with the JNI bindings"
make -j"$(nproc)" > /tmp/opencode/tskjava_make.log 2>&1 || { tail -20 /tmp/opencode/tskjava_make.log; exit 1; }

echo "[5/5] building the java jar"
(cd bindings/java && ant -q dist > /tmp/opencode/tskjava_ant.log 2>&1) || { tail -20 /tmp/opencode/tskjava_ant.log; exit 1; }

mkdir -p "$PREFIX/usr/share/java" "$PREFIX/usr/lib"
cp bindings/java/dist/sleuthkit-4.15.0.jar "$PREFIX/usr/share/java/"
cp bindings/java/jni/.libs/*.so.0.0.0 "$PREFIX/usr/lib/" 2>/dev/null
ln -sf "$PREFIX/usr/lib/libtsk_jni.so.0.0.0" "$PREFIX/usr/lib/libtsk_jni.so.0"
ln -sf "$PREFIX/usr/lib/libtsk_jni.so.0.0.0" "$PREFIX/usr/lib/libtsk_jni.so"

echo "DONE: $PREFIX/usr/share/java/sleuthkit-4.15.0.jar"
ls -l "$PREFIX/usr/share/java/" 2>/dev/null
