#!/usr/bin/bash

# a. Create a zip archive named xfusioncorp_blog.zip of /var/www/html/blog directory.
# b. save the archive in /backup/ location
cd /backup
zip -r xfusioncorp_blog.zip /var/www/html/blog/


# c. copy the archive to Nautilus backup server in /backup/ directory
# scp /backup/xfusioncorp_blog.zip clint@stbkp01:/backup/

# scp /backup/xfusioncorp_official.zip clint@stbkp01:/backup/

scp $(ls -t /backup/xfusioncorp_official.zip | head -n 1) clint@stbkp01:/backup/