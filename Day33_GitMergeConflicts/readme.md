

- - Storage Server
ssh natasha@ststor01

# Day 33 - Resolve Git Merge Conflicts
-- 12/14/2025
-- There are times to stay put, and what you want will come to you, and there are times to go out into the world and find such a thing for yourself.
– Lemony Snicket


Sarah and Max were working on writting some stories which they have pushed to the repository. Max has recently added some new changes and is trying to push them to the repository but he is facing some issues. Below you can find more details:

SSH into storage server using user max and password Max_xxxx123. Under /home/max you will find the story-blog repository. Try to push the changes to the origin repo and fix the issues. The story-index.txt must have titles for all 4 stories. Additionally, there is a typo in The Lion and the Mooose line where Mooose should be Mouse.

Click on the Gitea UI button on the top bar. You should be able to access the Gitea page. You can login to Gitea server from UI using username sarah and password Sarah_xxxx123 or username max and password Max_xxxx123.


Note: For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.


```bash
git config --global user.name "Max"
git config --global user.email "max@git.stratos.xfusioncorp.com"

cd story-blog/
git status
git branch
git remote -v
git log

vi story-index.txt 
git status
git add story-index.txt 
git commit -m "fixed typo in story-index.txt"

git push
# failed , see error below
git status
vi story-index.txt # correct the merge conflict
git status
git add story-index.txt 
git status
git commit -m "fixed merge conflict"
git push

```

max (master)$ git push
Username for 'http://git.stratos.xfusioncorp.com': max
Password for 'http://max@git.stratos.xfusioncorp.com': 
To http://git.stratos.xfusioncorp.com/sarah/story-blog.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'http://git.stratos.xfusioncorp.com/sarah/story-blog.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

