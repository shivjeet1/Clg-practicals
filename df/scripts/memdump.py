#!/usr/bin/env python3
"""Rootless volatile-memory capture of a running process.

LiME (Linux Memory Extractor) needs a kernel module and root privileges.
When root is not available the same *result* - the live contents of a
process address space, including heap strings the user has already seen -
can still be captured on Linux by reading /proc/<pid>/mem through the page
table that /proc/<pid>/maps exposes.

The kernel runs with yama ptrace_scope=1, so a process may only read the
memory of its own children.  The capture tool therefore *starts* the target
program itself and dumps it from the parent side.

Usage: memdump.py <output.raw> <map.txt> [--wait SECONDS] <command> [args...]
"""
import os
import subprocess
import sys
import time


def readable_regions(pid):
    """Return the readable mappings of a process, in address order."""
    regions = []
    with open(f"/proc/{pid}/maps", "r") as fh:
        for line in fh:
            parts = line.split()
            if len(parts) < 2 or parts[1][0] != "r":
                continue
            start, _, end = parts[0].partition("-")
            name = parts[-1] if len(parts) > 5 else "[anon]"
            regions.append((int(start, 16), int(end, 16), name))
    return regions


def dump(pid, out_path, map_path):
    regions = readable_regions(pid)
    dumped = 0
    hits = 0
    with open(out_path, "wb") as out:
        for start, end, name in regions:
            size = end - start
            try:
                with open(f"/proc/{pid}/mem", "rb", 0) as mem:
                    mem.seek(start)
                    data = mem.read(size)
            except (OSError, PermissionError):
                continue
            if not data:
                continue
            out.write(data)
            dumped += len(data)
            hits += 1
    return regions, dumped, hits


def main():
    args = sys.argv[1:]
    if len(args) < 3:
        print(__doc__)
        raise SystemExit(2)

    out_path, map_path = args[0], args[1]
    args = args[2:]

    wait = 3.0
    if args and args[0] == "--wait":
        wait = float(args[1])
        args = args[2:]

    print(f"[*] starting target: {' '.join(args)}")
    child = subprocess.Popen(args, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    time.sleep(wait)
    print(f"[*] target running with pid {child.pid}")

    regions, dumped, hits = dump(child.pid, out_path, map_path)

    print(f"[*] readable mappings : {len(regions)}")
    print(f"[*] mappings captured : {hits}")
    print(f"[*] bytes captured    : {dumped} ({dumped / 1048576:.2f} MiB)")
    print(f"[*] raw dump file     : {out_path}")

    with open(map_path, "w") as fh:
        fh.write(f"# volatile memory capture of pid {child.pid}\n")
        fh.write(f"# {out_path} : {dumped} bytes from {hits} mappings\n")
        for start, end, name in regions:
            fh.write(f"{start:016x}-{end:016x} {name}\n")
    print(f"[*] map file          : {map_path}")

    # keep the target alive so that the memory state can be inspected again
    print(f"[*] target stays alive as pid {child.pid} (kill it when finished)")


if __name__ == "__main__":
    main()
