# KodeKloud_100DaysOfDevOps
# Documentation

🚀 100 Days of DevOps – Real-World Projects and Challenges

This repo is for all my code, scripts, configs and exercises on KodeKloud 100 Days of DevOps Challenge. My goal is solve each exercise but also document and summarize my system design, architecture, decisions, trade-offs and actions.

# Clone my repo
```git
echo "# KodeKloud_100DaysOfDevOps" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main # renames your local branch to main
git remote add origin git@github.com:remisobayo/KodeKloud_100DaysOfDevOps.git
git push -u origin main
```

# Summary of Task


Day 15: Setup SSL for Nginx


Day 16: Nginx As A Load Balancer 
- I am using Nginx as a Load Balancer and sending all app requests to 3 backend app servers.
- Edit the config file /etc/nginx/nginx.conf to add the upstream block and the server block to http block.


Day 17:  Install and Configure PostgreSQL


Day 18: Configure a LAMP Server
 - This activity involves configuring a Linux, Apache, MySQL/MariaDB, PHP/Python/Perl. I had 3 application servers hosting my PHP application on Apache Web server running on port 6200 and connecting to 1 database server - MariaDB on port 3306. A Load Balancer LBR routes ingress traffic in a round robbing manner to the 3 app servers using HAProxy configured on the LBR server. The LBR servers http/https traffic coming from port 80 and 443 and routes them to the backend app servers.


Day 19: Install and Configure Web Applications
- 



Day 20:




Day 21: Set Up Git Repository on Storage Server
Working with Git. Install git and setup a version control repository using 'git init' command

Day 22: Clone Git Repository on Storage Server
Use 'git clone' to copy a git repository into another directory.

Day 23: Fork a Git Repository
Using the Version Control System UI, make a copy of an existing repo

Day 24: Git Create Branches
When checking out a branch, you are doing a copy of the current branch.
Most times make sure you are on the master branch before doing git checkout -b <new branch name>

Day 25: Git Merge Branches


Day 31: Git Stash



** my inspiration for documenting my progress was gotten from folaaramide/100-days-of-devops. **