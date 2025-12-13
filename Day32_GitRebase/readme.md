
- - Storage Server
ssh natasha@ststor01

# Day 32: Git Rebase
- 12/12/2025

- One day or day one. It's your choice.
- You are never too old to set another goal or to dream a new dream.
– Malala Yousafzai


The Nautilus application development team has been working on a project repository /opt/demo.git. This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. They recently shared the following requirements with DevOps team:

One of the developers is working on feature branch and their work is still in progress, however there are some changes which have been pushed into the master branch, the developer now wants to rebase the feature branch with the master branch without loosing any data from the feature branch, also they don't want to add any merge commit by simply merging the master branch into the feature branch. Accomplish this task as per requirements mentioned.

Also remember to push your changes once done.

# Task
- rebase the feature branch with the master branch without loosing any data from the feature branch
- don't add any merge commit by simply merging the master branch into the feature branch
- push your changes once done

```bash
cd /usr/src/kodekloudrepos/blog
git config --global --add safe.directory /usr/src/kodekloudrepos/blog
git branch
git checkout feature
sudo git rebase master
# Resolve conflicts, then:
git add .
git rebase --continue
git push --set-upstream origin feature
sudo git push --force-with-lease
git branch -a
git push --force-with-lease --set-upstream origin feature
git config --global --add safe.directory /opt/blog.git

sudo git push --force-with-lease --set-upstream origin feature
```

```text
[natasha@ststor01 blog]$ git statusOn branch feature
nothing to commit, working tree clean
```

```text
[natasha@ststor01 blog]$ git branch
* feature
  master
[natasha@ststor01 blog]$ sudo git push --set-upstream origin feature
[sudo] password for natasha: 
To /opt/blog.git
 ! [rejected]        feature -> feature (non-fast-forward)
error: failed to push some refs to '/opt/blog.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. If you want to integrate the remote changes,
hint: use 'git pull' before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

```text
[natasha@ststor01 blog]$ sudo git push --force-with-lease
fatal: The current branch feature has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin feature

To have this happen automatically for branches without a tracking
upstream, see 'push.autoSetupRemote' in 'git help config'.
```

```text
[natasha@ststor01 blog]$ git branch -a
* feature
  master
  remotes/origin/feature
  remotes/origin/master
```

```text
[natasha@ststor01 blog]$ git status                                      On branch feature
nothing to commit, working tree clean
```

```text
[natasha@ststor01 blog]$ git status
On branch feature
Your branch is up to date with 'origin/feature'.

nothing to commit, working tree clean
```