# Day 18 - Configuring LAMP Server
- 11/09/2025 - 
Those who hoard gold have riches for a moment. Those who hoard knowledge and skills have riches for a lifetime. – The Diary of a CEO

LAMP Server is a classic open source web service stack. The acronym LAMP stands for Linux Apache MySQL/MariaDB PHP/Perl/Python.

They have already done infrastructure configuration—for example, on the storage server they already have a shared directory /vaw/www/html that is mounted on each app host under /var/www/html directory. Please perform the following steps to accomplish the task:

a. Install httpd, php and its dependencies on all app hosts - stapp01, 
```bash
ssh tony@stapp01;
ssh steve@stapp02;
ssh banner@stapp03;
ssh loki@stlb01;
ssh peter@stdb01;

sudo yum install httpd php

#!/bin/bash

# Update system
sudo yum update -y

# Install Apache (httpd) and PHP with common extensions
sudo yum install -y httpd php php-mysqlnd php-json php-xml php-mbstring php-gd

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Configure firewall (if firewalld is running)
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

# Create a simple PHP info page for testing (optional)
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

# Set proper permissions (not done)
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Restart Apache to apply changes
sudo systemctl restart httpd

echo "Installation complete!"
echo "Apache and PHP have been installed successfully."
echo "You can test the installation by visiting: http://your-server-ip/info.php"
```
b. Apache should serve on port 6200 within the apps.
```bash
sudo sed -i 's/^Listen 80$/Listen 6200/' /etc/httpd/conf/httpd.conf
sudo systemctl reload httpd
```

# Make the change and verify
sudo sed -i 's/^Listen 80$/Listen 6200/' /etc/httpd/conf/httpd.conf && \
echo "Change made. Current Listen directives:" && \
sudo grep -E "^Listen" /etc/httpd/conf/httpd.conf && \
echo "Testing configuration..." && \
sudo httpd -t

# Testing connectivity
curl http://stapp01/index.php; curl http://stapp01:6200/index.php
curl http://stapp02/index.php; curl http://stapp02:6200/index.php
curl http://stapp03/index.php; curl http://stapp03:6200/index.php
curl http://stlb01.stratos.xfusioncorp.com;

# Database:
c. Install/Configure MariaDB server on DB Server.

# Update the system
sudo yum update -y

# Install MariaDB server
sudo yum install -y mariadb-server

# Install MariaDB client (optional but useful)
sudo yum install -y mariadb

# Start MariaDB service
sudo systemctl start mariadb

# Enable MariaDB to start automatically on boot
sudo systemctl enable mariadb

# Check status
sudo systemctl status mariadb

# Check error logs
sudo tail -f /var/log/mariadb/mariadb.log

2025-11-11  6:46:01 0 [Note] /usr/libexec/mariadbd: ready for connections.
Version: '10.5.29-MariaDB'  socket: '/var/lib/mysql/mysql.sock'  port: 3306  MariaDB Server

# Check MySQL processes
mysqladmin -u root -p processlist

# Check version
mysql -V

d. Create a database named kodekloud_db10 and create a database user named kodekloud_rin identified as password YchZHRcLkL. Further make sure this newly created user is able to perform all operation on the database you created.

# Connect as root
sudo mysql -u root -p

-- Create a new database
CREATE DATABASE kodekloud_db10;

-- Create a new user
CREATE USER 'kodekloud_rin'@'localhost' IDENTIFIED BY 'strongpassword';

-- Grant privileges to the user
GRANT ALL PRIVILEGES ON kodekloud_db10.* TO 'kodekloud_rin'@'localhost';

-- Grant privileges for remote access (if needed)
GRANT ALL PRIVILEGES ON kodekloud_db10.* TO 'kodekloud_rin'@'%' IDENTIFIED BY 'strongpassword';

-- Reload privileges
FLUSH PRIVILEGES;

-- Show users
SELECT user, host FROM mysql.user;


-- Exit
EXIT;

sudo mysql -e "SHOW DATABASES;"

-- Show all databases
SHOW DATABASES;

-- Use a specific database
USE database_name;

-- Show tables in current database
SHOW TABLES;

-- Describe table structure
DESCRIBE table_name;

-- Show current user
SELECT CURRENT_USER();

-- Show version
SELECT VERSION();

-- Exit
EXIT;

e. Finally you should be able to access the website on LBR link, by clicking on the App button on the top bar. You should see a message like App is able to connect to the database using user kodekloud_aim
- check that the LBR is pointing traffic to the app servers
- check that the app servers config is pointing to the database server

```bash
sudo ss -tulpn | grep :80
kill ; sudo systemctl start nginx
```
# Errors
Nov 11 07:15:29 stlb01.stratos.xfusioncorp.com nginx[3025]: nginx: [emerg] bind() t
o 0.0.0.0:80 failed (98: Address already in use)

2025/11/11 07:20:22 [warn] 3214#3214: *6 upstream server temporarily disabled while connecting to upstream, client: 127.0.0.1, server: _, request: "GET / HTTP/1.1", upstream: "http://172.16.238.10:8084/", host: "localhost"

# HAProxy - is already installed and configured on the LBR
tcp   LISTEN 0      2000         0.0.0.0:80         0.0.0.0:*    users:(("haproxy",pid=1372,fd=7))
sudo haproxy -c -f /etc/haproxy/haproxy.cfg