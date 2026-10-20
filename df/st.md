Here is a concise guide to performing each experiment using native Arch Linux tools and alternatives, bypassing the Windows-specific utilities mentioned in the manual:

**Experiment 1: Study of Forensics Tools**

* **What to do:** Install core forensic tools on your Arch system.
* **Arch Command:** `sudo pacman -S sleuthkit testdisk autopsy` (Autopsy might require AUR depending on the version you need, e.g., `yay -S autopsy`).

**Experiment 2: Recovery of Deleted Files**

* **What to do:** Create test files on a spare FAT32/exFAT USB drive, hash them, delete them, and recover them.
* **Arch Steps:**
1. Create files and hash them: `sha256sum /run/media/user/USB/case_note.txt`
2. Delete them: `rm /run/media/user/USB/case_note.txt`
3. Recover using PhotoRec: Run `sudo photorec` in your terminal, select your USB drive, choose the partition, and extract the recovered files to a safe local directory.



**Experiment 3: EXIF Data Extraction**

* **What to do:** Analyze metadata from photographs (taken yourself vs. downloaded from social media).
* **Arch Steps:**
1. Install ExifTool: `sudo pacman -S perl-image-exiftool`
2. Hash the images first: `sha256sum photo1.jpg`
3. Read the metadata: `exiftool photo1.jpg` (Compare the GPS and timestamp data of the original vs. the downloaded image).



**Experiment 4: Creating a Forensic Image**

* **What to do:** Create a bit-stream copy of a drive and verify its integrity.
* **Arch Steps:**
1. Identify your USB drive: `lsblk` (e.g., `/dev/sdb`)
2. Create the raw image and hash it simultaneously using `dcfldd` (install via `yay -S dcfldd`):
`sudo dcfldd if=/dev/sdb of=forensic_image.dd hash=sha256 hashlog=image_hash.txt`



**Experiment 5: Volatile Memory (RAM) Capture**

* **What to do:** Dump the system RAM and extract email/web artifacts.
* **Arch Steps:**
1. Dump RAM using LiME (Linux Memory Extractor - install via AUR `lime-dkms-git`):
`sudo insmod lime.ko "path=ram_dump.raw format=raw"`
2. Extract data: Install `bulk_extractor` (via AUR) and run: `bulk_extractor -o output_dir ram_dump.raw` to parse out emails, URLs, and network traffic.



**Experiment 6: Browser Artefacts**

* **What to do:** Extract browsing history, cache, and downloads.
* **Arch Steps:** (Bypassing NirSoft Windows utilities)
1. Install SQLite browser: `sudo pacman -S sqlitebrowser`
2. For Firefox, copy `~/.mozilla/firefox/*.default*/places.sqlite` to a working folder. For Chrome/Chromium, copy `~/.config/google-chrome/Default/History`.
3. Open the copied `.sqlite` files in `sqlitebrowser` to view URLs, timestamps, and download history natively.



**Experiment 7: Viewing Last PC Activity**

* **What to do:** Reconstruct a timeline of recent system events.
* **Arch Steps:**
1. Instead of LastActivityView, analyze system logs.
2. Check system boots/shutdowns: `journalctl --list-boots`
3. Check recent user logins: `last -a`
4. Check recent terminal commands: `cat ~/.bash_history` or `cat ~/.zsh_history`



**Experiment 8: Live Case Investigation**

* **What to do:** Ingest the disk image you created in Experiment 4 into a full forensic suite.
* **Arch Steps:**
1. Launch Autopsy (via terminal or application menu).
2. Create a "New Case" and add the `.dd` file from Exp 4 as a "Data Source".
3. Run ingest modules (like Hash Lookup, Keyword Search, and Recent Activity).
4. Browse the extracted artifacts in the GUI and generate your final HTML/PDF report.
