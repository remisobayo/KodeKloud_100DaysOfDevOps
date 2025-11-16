# Install and Configure Web Server

a. Install httpd package and dependencies on app server 1.
```bash
sudo yum install httpd -y
```
# Start and enable Apache
```bash
sudo systemctl start httpd
sudo systemctl enable httpd
```

b. Apache should serve on port 3001.
```bash
sudo sed -i 's/^Listen 80$/Listen 3001/' /etc/httpd/conf/httpd.conf
sudo systemctl reload httpd
```

c. There are two website's backups /home/thor/ecommerce and /home/thor/cluster on jump_host. Set them up on Apache in a way that ecommerce should work on the link http://localhost:3001/ecommerce/ and cluster should work on link http://localhost:3001/cluster/ on the mentioned app server.

- Using Different Directories with Location Directives

# create the application directories on the app server
```bash
ssh tony@stapp01 "sudo mkdir -p /var/www/ecommerce /var/www/cluster"
```
- Error
sudo: a terminal is required to read the password; either use the -S option to read from standard input or configure an askpass helper
sudo: a password is required

# copy the application from jump server to the app server
```bash
sudo chown -R $USER:$USER /var/www/ecommerce /var/www/cluster

scp -r /home/thor/ecommerce/* tony@stapp01:/var/www/ecommerce/
scp -r /home/thor/cluster/* tony@stapp01:/var/www/cluster/

sudo chown -R root:root /var/www/ecommerce
sudo chown -R root:root /var/www/cluster
sudo chmod -R 755 /var/www
```

# Edit the config file
- Add aliases and their directory
```bash
sudo vi /etc/httpd/conf/httpd.conf
```

# Validate the changes and test the application
- Check config syntax
```bash 
sudo httpd -t
sudo systemctl reload httpd
```

- Check if Apache is listening on port 3001
```bash
sudo ss -tulpn | grep :3001
```

d. Once configured you should be able to access the website using curl command on the respective app server, i.e 
```bash
curl http://localhost:3001/ecommerce/
curl http://localhost:3001/cluster/
```

# Check error logs
```sh
journalctl -xeu httpd.service
sudo tail -f /var/log/httpd/port3001_access.log
sudo tail -f /var/log/httpd/port3001_error.log
sudo tail -f /var/log/httpd/error.log
/var/log/httpd/
```

# Errors
[tony@stapp01 ~]$ curl http://localhost:3001/cluster
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>404 Not Found</title>
</head><body>
<h1>Not Found</h1>
<p>The requested URL was not found on this server.</p>
</body></html>

Cause - The aliases have not been configured on the httpd.conf file

