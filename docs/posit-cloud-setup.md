# Setting up the Posit Cloud door

For Claire, before the email goes out. About thirty minutes. Do it once
with Cecile joining from her own account so you have seen both sides.

## What you are building

A **Space** that attendees join by link. Inside it, one **project** marked
as an **assignment**. When an attendee opens an assignment, Posit Cloud
makes them a private copy with everything already installed. They cannot
break yours, and you never see theirs unless they share.

## Plan

The free plan gives one space with limits on members and projects, 25
compute hours a month, and 1 GB of RAM per project. The Instructor plan is
$15 per month: unlimited spaces, 300 hours, 16 GB. Buy one month of
Instructor. The attendees stay on free accounts; compute in your space
counts against your plan, which is the point.

Verified today at https://posit.cloud/plans. Cancel after the workshop.

## Steps

1. **Account.** https://posit.cloud, sign up with your Auburn email. Upgrade
   to Instructor from the plans page.

2. **Space.** Left sidebar, *New Space*. Name it `IR + Quarto Workshop`.
   Under *Members* or *Settings*, set access so that *anyone with the link
   can join* (the wording in the interface may differ; look for a sharing
   link). Copy the link. That is what goes in the email.

3. **Project.** Inside the space, *New Project* > *New RStudio Project*.
   Name it `IR-Quarto-Workshop`. It opens as a blank RStudio in the browser.

4. **Upload.** Files pane > *Upload*. Upload the project zip (the one you
   will give Door 1 people). It unzips in place. Make sure the `.Rproj`,
   `setup/`, `data/`, `exercises/` folders are at the top level, not nested
   one folder down. If nested, move them up.

5. **Install packages once, for everyone.** Open
   `setup/00_install_packages.R`, click Source. This takes longer here than
   on a laptop; ten minutes is normal. Then Source `setup/01_check_setup.R`
   and get "Ready". Render `exercises/00_hello.qmd` and
   `exercises/01_my_institution.qmd` once so you know they work in 1 GB.

6. **Make it an assignment.** Back in the space's project list, the project
   has a menu (gear or three dots). Choose *Make Assignment*. From now on
   every member who clicks it gets their own copy.

7. **Test from the outside.** Cecile, on her own free account, opens the
   space link, joins, clicks the assignment, waits for the copy, renders
   `01_my_institution.qmd` with her UNITID. Time it. If the render runs out
   of memory, tell me and I will slim the data further.

8. **Export.** In Cecile's copy: Files pane, tick a file, *More* > *Export*.
   That is how attendees get work off the cloud. It goes in the handout.

## Interface caveat

Posit changes the Cloud interface now and then. The nouns above (Space,
Member, Assignment, Export) have been stable; the exact menu locations may
not be. If a step does not match what you see, the help is at
https://docs.posit.co/cloud/ and the search term is "assignment".

## On the day

Attendees who cannot install anything go to the space link, make an
account, join, click. Have the link printed large on the handout and
written on the board.
