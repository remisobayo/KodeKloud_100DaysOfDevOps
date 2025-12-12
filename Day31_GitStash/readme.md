
- Storage Server
ssh natasha@ststor01

# Day 31: Git Stash
- 12/12/2025

The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/demo present on Storage server in Stratos DC. One of the developers stashed some in-progress changes in this repository, but now they want to restore some of the stashed changes. Find below more details to accomplish this task:

Look for the stashed changes under /usr/src/kodekloudrepos/demo git repository, and restore the stash with stash@{1} identifier. Further, commit and push your changes to the origin.

```bash
cd /usr/src/kodekloudrepos/demo
git config --global --add safe.directory /usr/src/kodekloudrepos/demo
git status
git stash list
git stash show stash@{1}
git stash pop stash@{1}
sudo git stash pop stash@{1}
sudo git add welcome.txt
sudo git commit -m "second commit"
sudo git push
```

```text
[natasha@ststor01 demo]$ git stash list
stash@{0}: WIP on master: 61fcf38 initial commit
stash@{1}: WIP on master: 61fcf38 initial commit
```

```text
[natasha@ststor01 demo]$ git stash show stash@{1}
 welcome.txt | 1 +
 1 file changed, 1 insertion(+)
```

```text
[natasha@ststor01 demo]$ git stash pop stash@{1}
error: could not write index
The stash entry is kept in case you need it again.
```

```text
[natasha@ststor01 demo]$ sudo git stash pop stash@{1}
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   welcome.txt

Dropped stash@{1} (93ff4a4daef492ef2771f1bd6fccdf75385c6ee8)
```

```text
[natasha@ststor01 demo]$ git remote -v
origin  /opt/demo.git (fetch)
origin  /opt/demo.git (push)
```

```text
[natasha@ststor01 demo]$ git log
commit c99f901a8cda0dbcad771a33a5298e02dac1e397 (HEAD -> master, origin/master)
Author: Admin <admin@kodekloud.com>
Date:   Fri Dec 12 10:18:00 2025 +0000

    second commit

commit 61fcf3810c92e70d897f62cd8aec719856156cbc
Author: Admin <admin@kodekloud.com>
Date:   Fri Dec 12 09:54:12 2025 +0000

    initial commit
```