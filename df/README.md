# Digital Forensics — Practical Experiments

Eight experiments executed on **Arch Linux** (kernel 7.1.9-arch1-2) with native
forensic tooling, as an alternative to the Windows utilities named in the lab manual.

| # | Experiment | Document | Screenshots |
|---|---|---|---|
| 1 | Study of Forensics Tools | [exp1.md](exp1.md) | 3 |
| 2 | Recovery of Deleted Files | [exp2.md](exp2.md) | 4 |
| 3 | EXIF Data Extraction | [exp3.md](exp3.md) | 3 |
| 4 | Creating a Forensic Image | [exp4.md](exp4.md) | 3 |
| 5 | Volatile Memory (RAM) Capture | [exp5.md](exp5.md) | 3 |
| 6 | Browser Artefacts | [exp6.md](exp6.md) | 4 |
| 7 | Viewing Last PC Activity | [exp7.md](exp7.md) | 3 |
| 8 | Live Case Investigation | [exp8.md](exp8.md) | 9 |

The original guidance for these experiments is in [st.md](st.md).

---

## Tool chain

| Tool | Version | Purpose |
|---|---|---|
| The Sleuth Kit | 4.15.0 | `fls` `istat` `icat` `tsk_recover` `tsk_loaddb` `mactime` |
| TestDisk / PhotoRec | 7.2 | signature based carving of deleted files |
| ExifTool | 13.55 | image / document metadata |
| mtools | 4.0.49 | FAT32 image access without mounting |
| dcfldd | 1.9.3 | `dd` replacement that hashes while copying |
| SQLite / DB Browser | 3.53.4 / 3.13.1 | browser history databases |
| Volatility 3 | 2.28.2 | memory analysis |
| OpenJDK | 17 | Java runtime for the Autopsy GUI |
| Autopsy | 4.23.1 | the graphical forensic suite (case wizard, ingest modules) |

### Installation

The official installation is

```bash
sudo pacman -S sleuthkit testdisk perl-image-exiftool sqlitebrowser mtools
yay -S dcfldd
```

This machine has no `sudo` credentials, so the **identical** packages were fetched with
`pacman -Sp` and unpacked into the local prefix `tools/` — no root required:

```bash
./scripts/install_tools.sh sleuthkit testdisk perl-image-exiftool mtools sqlitebrowser
export PATH="$PWD/tools/bin:$PATH"
```

---

## Directory layout

```
df/
├── st.md                       the original experiment guide
├── exp1.md … exp8.md           one document per experiment
├── output/                     the screenshots of every experiment
├── artifacts/                  the working files of each experiment
│   ├── exp2/                   usb_drive.img, recovered files, hash manifests
│   ├── exp3/                   the three test pictures
│   ├── exp4/                   forensic_image.dd + hash log
│   ├── exp5/                   mem_target.py, ram_dump.raw, memory_map.txt
│   ├── exp6/                   the copy of places.sqlite
│   └── exp8/                   the case directory of the live investigation
├── scripts/                    the helper scripts used by the experiments
│   ├── install_tools.sh        rootless package installation
│   ├── pacman_resolve.py       dependency resolver (reads the pacman sync db)
│   ├── make_wrappers.sh        LD_LIBRARY_PATH wrappers for tools/bin
│   ├── fix_symlinks.sh         repoints absolute symlinks into the prefix
│   ├── capture.sh              runs commands in a terminal and screenshots it
│   ├── capture_gui.sh          screenshots a GUI application
│   ├── dbbrowser_capture.sh    opens DB Browser for SQLite and captures it
│   ├── memdump.py              rootless volatile memory capture
│   ├── case_ingest.sh          the complete case workflow of experiment 8
│   └── tool_inventory.sh       the tool table of experiment 1
└── tools/                      the locally installed tool chain (not in git)
```

---

## Reproducing the screenshots

```bash
export PATH="$PWD/tools/bin:$PATH"

# run the commands of an experiment inside a real terminal and capture it
./scripts/capture.sh output/exp2-04-photorec-carving.png artifacts/exp2/cmd4.txt "$PWD"

# capture a GUI application
./scripts/capture_gui.sh /tmp/gui.png 8 sqlitebrowser artifacts/exp6/working/places.sqlite
```

`capture.sh` opens an `st` window on the live X display, runs the commands with a
`user@arch:…$` prompt, waits for them to finish, captures **that window only** (matched
by `_NET_WM_PID`, so no other window of the desktop is ever included) and crops the
image to the printed content.

---

## Notes and deviations from the manual

| Manual (Windows) | Used here | Why |
|---|---|---|
| NirSoft *LastActivityView* | `journalctl`, `last`, `who`, shell history | no equivalent tool exists for Linux; the journal holds the same information |
| *PhotoRec* on a USB drive | *PhotoRec* on a FAT32 **image file** of the stick | the VM has no physical USB device; PhotoRec and the Sleuth Kit read image files identically |
| `sudo insmod lime.ko` | `/proc/<pid>/mem` capture (`scripts/memdump.py`) | loading a kernel module and reading `/proc/kcore` need root; the LiME procedure is documented in exp5.md |
| `bulk_extractor` | `strings` + `grep` (the same scanner logic) | `bulk_extractor` is no longer packaged for Arch; the command is documented in exp5.md |
| *Autopsy* GUI | **Autopsy 4.23.1 itself** (installed with a local Java 17 runtime and the Java bindings of The Sleuth Kit) + a Sleuth Kit CLI case with the same database schema and an HTML report | three of the bundled Autopsy modules are Windows-only and abort the ingest on Linux — see exp8.md |
