#!/usr/bin/env python3
"""Resolve a package dependency closure straight from pacman's sync database.

`pacman -Sp` only prints the URLs of the packages you name, and this pacman
build has no `--recursive` option, so the closure is computed here by reading
the sync databases (/var/lib/pacman/sync/*.db) directly.

Usage:  pacman_resolve.py <package> [package ...]
Output: one package name per line (only those missing from the system).
"""
import subprocess
import sys
import tarfile
from pathlib import Path

SYNC_DIR = Path("/var/lib/pacman/sync")


def load_sync_db() -> dict:
    """Return {pkgname: (depends, provides)} for every package in the sync DBs."""
    pkgs: dict = {}
    for db in sorted(SYNC_DIR.glob("*.db")):
        try:
            with tarfile.open(db) as tar:
                for member in tar.getmembers():
                    if not member.name.endswith("/desc"):
                        continue
                    desc = tar.extractfile(member).read().decode("utf-8", "replace")
                    fields = parse_desc(desc)
                    name = fields.get("NAME", "")
                    if name:
                        pkgs[name] = (fields.get("DEPENDS", ""), fields.get("PROVIDES", ""))
        except (tarfile.TarError, OSError):
            continue
    return pkgs


def installed_packages() -> set:
    out = subprocess.run(["pacman", "-Q"], capture_output=True, text=True).stdout
    return {line.split()[0] for line in out.splitlines() if line.strip()}


def parse_desc(desc: str) -> dict:
    """Parse a pacman .desc file: `%KEY%` headers followed by value lines."""
    fields: dict = {}
    key = None
    buf: list = []
    for line in desc.splitlines():
        if line.startswith("%") and line.endswith("%") and len(line) > 2:
            if key:
                fields[key] = "\n".join(buf).strip()
            key = line[1:-1].strip()
            buf = []
        elif key:
            buf.append(line)
    if key:
        fields[key] = "\n".join(buf).strip()
    return fields


def dep_names(depends: str) -> list:
    """Split a DEPENDS=/PROVIDES= value into bare dependency names.

    Pacman stores one dependency per line; older dbs use comma separation.
    """
    deps = []
    for dep in depends.replace(",", "\n").splitlines():
        dep = dep.strip()
        if not dep:
            continue
        for sep in (">=", "<=", "=", ">"):
            if sep in dep:
                dep = dep.split(sep)[0]
                break
        deps.append(dep.strip())
    return deps


def main() -> None:
    if len(sys.argv) < 2:
        print("usage: pacman_resolve.py <package>...", file=sys.stderr)
        raise SystemExit(2)

    pkgs = load_sync_db()
    installed = installed_packages()

    # provider index: virtual name -> concrete package name
    providers: dict = {}
    for name, (_depends, provides) in pkgs.items():
        providers[name] = name
        for prov in dep_names(provides):
            providers.setdefault(prov, name)

    resolved: list = []
    queue = list(sys.argv[1:])
    seen: set = set()
    while queue:
        want = queue.pop(0)
        if want in seen:
            continue
        seen.add(want)
        concrete = providers.get(want)
        if concrete is None:
            continue  # unknown / already satisfied by the base system
        depends, _provides = pkgs[concrete]
        for dep in dep_names(depends):
            if dep not in seen:
                queue.append(dep)
        if concrete not in installed and concrete not in resolved:
            resolved.append(concrete)

    for name in sorted(resolved):
        print(name)


if __name__ == "__main__":
    main()
