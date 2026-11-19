#!/usr/bin/env python3
"""Keep stopgaps that wait on a UZ Core release tied to their issues.

When this IG needs something UZ Core has merged but not released, the
workaround is tracked by an issue labelled `needs-core-release`, and every
spot to undo carries a marker naming it: `CORE-RELEASE #123` in a comment.

Every run:
- fails if a marker names an issue that is missing, closed or not labelled
  (the issue was closed but the code still has the workaround);
- warns if an open labelled issue has no marker left (close it);
- lists the markers in the job summary, so a PR that bumps uz.dhp.core
  shows what the new core release may unblock.

With --release (a PR that bumps `version:`, and the Release workflow) it
also fails while any marker or open labelled issue remains.

Usage: check_core_release_markers.py [--release]
Run from the repository root; needs `gh` with a token that can read issues.
"""
import json
import os
import re
import subprocess
import sys

LABEL = "needs-core-release"
MARKER = re.compile(r"CORE-RELEASE #(\d+)")
SKIP = (".github/", "RELEASING.md")


def git_files():
    out = subprocess.run(["git", "ls-files", "input", "sushi-config.yaml"],
                         capture_output=True, text=True, check=True).stdout
    return [f for f in out.splitlines() if not f.startswith(SKIP)]


def find_markers():
    markers = {}
    for path in git_files():
        try:
            with open(path, encoding="utf-8") as fh:
                for n, line in enumerate(fh, 1):
                    for m in MARKER.finditer(line):
                        markers.setdefault(int(m.group(1)), []).append(f"{path}:{n}")
        except (UnicodeDecodeError, IsADirectoryError, FileNotFoundError):
            continue
    return markers


def gh_json(*args):
    out = subprocess.run(["gh", *args], capture_output=True, text=True)
    if out.returncode != 0:
        return None
    return json.loads(out.stdout)


def repo():
    if os.environ.get("GITHUB_REPOSITORY"):
        return os.environ["GITHUB_REPOSITORY"]
    return gh_json("repo", "view", "--json", "nameWithOwner")["nameWithOwner"]


def main():
    release = "--release" in sys.argv[1:]
    r = repo()
    markers = find_markers()
    labelled = gh_json("issue", "list", "--repo", r, "--label", LABEL, "--state", "open",
                       "--limit", "200", "--json", "number,title") or []
    open_issues = {i["number"]: i["title"] for i in labelled}

    errors, warnings, rows = [], [], []
    for num, places in sorted(markers.items()):
        if num in open_issues:
            rows.append((num, open_issues[num], places))
            continue
        issue = gh_json("issue", "view", str(num), "--repo", r, "--json", "state,labels,title")
        where = ", ".join(places)
        if issue is None:
            errors.append(f"CORE-RELEASE #{num} names an issue that does not exist ({where})")
        elif issue["state"] != "OPEN":
            errors.append(f"CORE-RELEASE #{num} is closed but its marker remains - finish the change or reopen it ({where})")
        else:
            errors.append(f"CORE-RELEASE #{num} is not labelled {LABEL} ({where})")
        rows.append((num, issue["title"] if issue else "?", places))

    for num, title in sorted(open_issues.items()):
        if num not in markers:
            warnings.append(f"#{num} ({title}) is labelled {LABEL} but no CORE-RELEASE #{num} marker is left - close it once the change is merged")

    if release:
        for num, title, places in rows:
            errors.append(f"release blocked: CORE-RELEASE #{num} ({title}) still at {', '.join(places)}")
        for num, title in sorted(open_issues.items()):
            if num not in markers:
                errors.append(f"release blocked: #{num} ({title}) is still open")

    summary = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary and rows:
        with open(summary, "a", encoding="utf-8") as fh:
            fh.write("### Waiting on a UZ Core release\n\n| Issue | Where |\n|---|---|\n")
            for num, title, places in rows:
                fh.write(f"| #{num} {title} | {'<br>'.join(places)} |\n")
            fh.write("\n")

    for num, title, places in rows:
        print(f"CORE-RELEASE #{num} ({title}): {', '.join(places)}")
    for w in warnings:
        print(f"::warning::{w}")
    for e in errors:
        print(f"::error::{e}")
    if not rows and not open_issues:
        print("No CORE-RELEASE markers or open needs-core-release issues.")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
