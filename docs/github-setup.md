# Putting the workshop on your own GitHub

For Claire. Every step here is one you run yourself, in a browser or in
RStudio's Terminal tab. Nothing needs my access to anything. About twenty
minutes the first time.

## One login, two owners

Your account is `AuburnClaire` at github.com. The office repositories
(`IR-SQL`, `IR-Reports`) live under an **organization** on the same site,
`Auburn-IR-Web`, which you belong to. Same login, same site. The only
difference between an office repository and a personal one is the
**Owner** you pick when you create it.

This workshop goes under `AuburnClaire`, not the organization, because
attendees from nine institutions will download it and the organization is
for Auburn's work. If the office later wants it under `Auburn-IR-Web`, a
repository can be transferred in one click from its Settings page.

## Before anything leaves your machine

Open the project folder and confirm three things:

1. `.gitignore` is there and excludes `PPD-data/`, `output/`, rendered
   `.html` and `.pdf` except the handout folder, and `.Renviron`.
2. `output/prerendered/` exists only locally. It is the attendee list by
   another name and it is ignored.
3. Nothing in the folder names a DSN, a share, a schema, a password, or a
   person who is not an author. (Swept on October 11; sweep again after
   any edit: in the Terminal, `git grep -i -E "banprod|auo7|keyring::key_"`
   once the repo exists.)

## Step 1: the account

Already done. You are signed in as `AuburnClaire`. Two-factor is almost
certainly on already because the organization requires it; confirm under
Settings > Password and authentication.

## Step 2: the empty repository on GitHub

1. Top right, the **+** button, **New repository**.
2. **Owner:** the dropdown on the left of the name box. Choose
   `AuburnClaire`, not `Auburn-IR-Web`. This is the whole difference.
3. Name: `IR-Quarto-Workshop`. Keep the same name as the folder.
4. Public.
5. Leave every box unchecked: no README, no .gitignore, no license. The
   folder already has what it needs; an empty remote avoids a merge on the
   first push.
6. **Create repository.** GitHub shows a page of commands. You will use
   the ones under "push an existing repository".

## Step 3: tell git who you are (once per machine)

Neither `IR-SQL` nor `IR-Reports` has a name or email set in git, which
means whatever tool made those commits supplied them. Set it once so the
Terminal can commit too. RStudio Terminal tab, project open:

```bash
git config --global user.name "Claire Heacox"
git config --global user.email "the email on your AuburnClaire account"
```

One account, one email, so `--global` is right.

## Step 4: make the folder a repository and commit

Still in the Terminal, inside the project folder (it opens there):

```bash
git init
git add .
git status
```

Read the `git status` list. It is everything about to go in. You should
see `setup/`, `data/`, `exercises/`, `handout/`, `docs/`, `ingest/`,
`solutions/`, `templates/`, the README, the `.Rproj`, the `.gitignore`.
You should **not** see `PPD-data/`, `output/`, or any `.html`. If you do,
stop and fix `.gitignore`, then `git add .` again.

```bash
git commit -m "Workshop materials: STATS report exercises, handout, primer, IPEDS template"
```

## Step 5: connect and push

From the page GitHub showed you, three lines:

```bash
git remote add origin https://github.com/AuburnClaire/IR-Quarto-Workshop.git
git branch -M main
git push -u origin main
```

You already push to `Auburn-IR-Web` from this machine over HTTPS, so the
credential that makes that work is the same one this push uses. It should
go through without asking. If a browser sign-in window appears, that is
Git Credential Manager confirming once; sign in as `AuburnClaire`.

Refresh the repository page. Your files are there.

## Step 6: the links for the email

**The zip.** GitHub makes one automatically:

```
https://github.com/AuburnClaire/IR-Quarto-Workshop/archive/refs/heads/main.zip
```

One catch: it unzips to a folder named `IR-Quarto-Workshop-main`, and the
handout tells everyone to put it at `C:\IR-Quarto-Workshop`. Either tell
them to rename the folder, or do this instead:

**A Release with a properly named zip.** On the repository page, right
sidebar, **Releases** > **Create a new release**. Tag `v1`, title
"Workshop, October 2026". Under "Attach binaries", drop a zip you made
yourself whose top-level folder is `IR-Quarto-Workshop`. (Right-click the
folder in Explorer, Send to > Compressed folder, after deleting or moving
`PPD-data` and `output` out of the way, or zip a fresh `git clone` of the
repo, which has neither.) The link to that file is the one for the email
and the handout.

## Updating later

After any change, in the Terminal:

```bash
git add .
git commit -m "What changed, in a few words"
git push
```

Or the RStudio **Git** tab, which appears once the repository exists: tick
the files, Commit, write the message, Push. Same thing with buttons.

## If you would rather not type git

**GitHub Desktop** (desktop.github.com) does Steps 4 and 5 with a window:
File > Add local repository, choose the folder, Publish repository, pick
Public. It handles sign-in. Everything above still applies; it is just
pressing the same buttons.

## What I can and cannot do here

I can run the local steps for you on this machine, `git init` through
`git commit`, with nothing leaving the computer, and show you the status
list before committing. The push, the account, and the browser sign-in
are yours. If you ever did want me to push, the least you would hand over
is a token scoped to this one repository, which GitHub lets you make under
Settings > Developer settings > Fine-grained tokens, and which you can
revoke the minute the workshop is over. You do not need to, and I would
not ask.
