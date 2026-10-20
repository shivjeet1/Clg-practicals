#!/usr/bin/env python3
"""A stand-in for the 'suspect' application whose RAM is examined in
Experiment 5.  It keeps a set of artefacts (mail address, URL, password,
document fragment) in live memory so that they can be found in the capture.
"""
import sys
import time

MAIL = "shivam.lawale@example.com"
URL = "https://login.protonmail.com/u/0/inbox?ref=forensics"
PASSWORD = "Suspect@Delhi2026"
DOC = ("Meeting notes 18-10-2026: the client asked to shift the balance of "
       "USD 250,000 to a second account in Dubai before the audit on Friday. "
       "Contact the branch manager Mr. R. Kulkarni.")
CHAT = ("[23:41] said the packet never reached Talegaon, keep it under the "
        "floorboard until Friday")


def main():
    # keep everything referenced so the optimiser cannot drop it
    blob = [MAIL, URL, PASSWORD, DOC, CHAT]
    print(f"target application started, pid={__import__('os').getpid()}")
    print(f"mail      : {MAIL}")
    print(f"url       : {URL}")
    print(f"document  : {DOC[:60]}...")
    sys.stdout.flush()
    for _ in range(600):
        time.sleep(1)


if __name__ == "__main__":
    main()
