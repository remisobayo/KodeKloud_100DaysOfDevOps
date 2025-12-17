
- Storage Server
ssh natasha@ststor01

# Day 34: Git Hook
- 12/15/2025
The more that you read, the more things you will know. The more that you learn, the more places you'll go.
– Dr. Seuss

You can’t go back and change the beginning, but you can start where you are and change the ending.
– C.S. Lewis

The Nautilus application development team was working on a git repository /opt/demo.git which is cloned under /usr/src/kodekloudrepos directory present on Storage server in Stratos DC. The team want to setup a hook on this repository, please find below more details:

- Merge the feature branch into the master branch, but before pushing your changes complete below point.

- Create a post-update hook in this git repository so that whenever any changes are pushed to the master branch, it creates a release tag with name release-2023-06-15, where 2023-06-15 is supposed to be the current date. For example if today is 20th June, 2023 then the release tag must be release-2023-06-20. Make sure you test the hook at least once and create a release tag for today's release.

Finally remember to push your changes.
Note: Perform this task using the natasha user, and ensure the repository or existing directory permissions are not altered.

```bash
cd /usr/src/kodekloudrepos/demo
git status
ls -al .git/hooks # shows sample hooks
```

```text
[natasha@ststor01 demo]$ git status
On branch feature
nothing to commit, working tree clean
```

```text
[natasha@ststor01 demo]$ ls -al .git/hooks
total 72
drwxr-xr-x 2 natasha natasha 4096 Dec 16 08:01 .
drwxr-xr-x 8 natasha natasha 4096 Dec 16 08:03 ..
-rwxr-xr-x 1 natasha natasha  482 Dec 16 08:01 applypatch-msg.sample
-rwxr-xr-x 1 natasha natasha  900 Dec 16 08:01 commit-msg.sample
-rwxr-xr-x 1 natasha natasha 4726 Dec 16 08:01 fsmonitor-watchman.sample
-rwxr-xr-x 1 natasha natasha  193 Dec 16 08:01 post-update.sample
-rwxr-xr-x 1 natasha natasha  428 Dec 16 08:01 pre-applypatch.sample
-rwxr-xr-x 1 natasha natasha 1653 Dec 16 08:01 pre-commit.sample
-rwxr-xr-x 1 natasha natasha  420 Dec 16 08:01 pre-merge-commit.sample
-rwxr-xr-x 1 natasha natasha 1378 Dec 16 08:01 pre-push.sample
-rwxr-xr-x 1 natasha natasha 4902 Dec 16 08:01 pre-rebase.sample
-rwxr-xr-x 1 natasha natasha  548 Dec 16 08:01 pre-receive.sample
-rwxr-xr-x 1 natasha natasha 1496 Dec 16 08:01 prepare-commit-msg.sample
-rwxr-xr-x 1 natasha natasha 2787 Dec 16 08:01 push-to-checkout.sample
-rwxr-xr-x 1 natasha natasha 2312 Dec 16 08:01 sendemail-validate.sample
-rwxr-xr-x 1 natasha natasha 3654 Dec 16 08:01 update.sample
```

```text
-rw-r--r-- 1 natasha natasha  370 Dec 16 08:33 post-update
```

```text
[natasha@ststor01 hooks]$ cat post-update.sample
#!/usr/bin/sh
#
# An example hook script to prepare a packed repository for use over
# dumb transports.
#
# To enable this hook, rename this file to "post-update".

exec git update-server-info
```

# Task on remote repo
The hooks should be placed on the remote directory not on the local repo. First attempt /opt/demo.git, second attempt /opt/beta.git.

```bash
cd /opt/demo.git
ls -al hooks/
touch hooks/post-update
vi hooks/post-update
# add the scripts in post-update.sh
chmod +x /opt/beta.git/hooks/post-update
chmod +x /opt/demo.git/hooks/post-update  # Make executable
cat post-update.sample
```

```text
[natasha@ststor01 beta.git]$ ls -al
total 40
drwxr-xr-x  7 natasha natasha 4096 Dec 16 09:23 .
drwxr-xr-x  1 root    root    4096 Dec 16 09:23 ..
-rw-r--r--  1 natasha natasha   23 Dec 16 09:23 HEAD
drwxr-xr-x  2 natasha natasha 4096 Dec 16 09:23 branches
-rw-r--r--  1 natasha natasha   66 Dec 16 09:23 config
-rw-r--r--  1 natasha natasha   73 Dec 16 09:23 description
drwxr-xr-x  2 natasha natasha 4096 Dec 16 09:26 hooks
drwxr-xr-x  2 natasha natasha 4096 Dec 16 09:23 info
drwxr-xr-x 10 natasha natasha 4096 Dec 16 09:23 objects
drwxr-xr-x  4 natasha natasha 4096 Dec 16 09:23 refs
```

```text
-rwxr-xr-x 1 natasha natasha  528 Dec 16 09:28 post-update
```

# Task on the local repo
- pushing the changes to the remote repo

```bash
git branch
git checkout master
git merge feature
git remote -v
```

```text
[natasha@ststor01 demo]$ git branch
* feature
  master
```

```text
[natasha@ststor01 demo]$ git checkout master
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
```

```text
[natasha@ststor01 demo]$ git merge feature
Updating faf693c..3241551
Fast-forward
 feature.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 feature.txt
```

```bash
git push origin master
```

```text
[natasha@ststor01 beta]$ git push origin master
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Created tag: release-2025-12-16
To /opt/beta.git
   a80a26e..08475d5  master -> master
```

# Verify/validate the tag
```bash
cd /opt/demo.git
git tag -l  # OR
git tag -l --format='%(refname:short) %(creatordate)' # OR
tail -f /tmp/post-update-debug.log
git reflog show --all
# OR 
git ls-remote --tags origin # from local repo
```

```text
[natasha@ststor01 beta.git]$ git tag -l 
release-2025-12-16
```

```text
[natasha@ststor01 beta.git]$ tail -f /tmp/post-update-debug.log
Hook triggered at Tue Dec 16 09:43:10 UTC 2025
Args: refs/heads/master
```

```text
[natasha@ststor01 beta]$ git ls-remote --tags origin
08475d57a667621c46380f8edb2d2a8c8101a822        refs/tags/release-2025-12-16
```

```bash
# Added another commit for testing  
git branch
git checkout feature
vi feature.txt 
git status
git add feature.txt 
git commit -m "updated feature.txt with tag info"
git config --global user.name "Natasha"
git config --global user.email "natasha@git.stratos.xfusioncorp.com"
git commit -m "updated feature.txt with tag info"
git status
git checkout master
git merge feature
git branch
git push
```