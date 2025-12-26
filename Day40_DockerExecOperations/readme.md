

# Day 40 - Docker EXEC Operations
- 12/25/2025
-The way to get started is to quit talking and begin doing.
– Walt Disney

One of the Nautilus DevOps team members was working to configure services on a kkloud container that is running on App Server 2 in Stratos Datacenter. Due to some personal work he is on PTO for the rest of the week, but we need to finish his pending work ASAP. Please complete the remaining work as per details given below:

a. Install apache2 in kkloud container using apt that is running on App Server 2 in Stratos Datacenter.

Server - ssh steve@stapp02

```bash
docker ps -a
# exec into the container
docker exec -it --detach-keys="ctrl-d" kkloud /bin/bash
apt update
apt install -y apache2
service apache2 start
service apache2 status
ps aux | grep apache

# running the commands in one line
docker exec kkloud bash -c "apt update && apt install -y apache2 && service apache2 start"
update-rc.d apache2 defaults  # ensure apache starts on container boot
docker commit kkloud <new_image_name>  # to persist the changes to an image, commit the container changes and Update your container configuration to use the new image.
```

b. Configure Apache to listen on port 3003 instead of default http port. Do not bind it to listen on specific IP or hostname only, i.e it should listen on localhost, 127.0.0.1, container ip, etc.

```bash
# Edit file - /etc/apache2/ports.conf
cp /etc/apache2/ports.conf /etc/apache2/ports.conf.backup
apt install -y vim
vi /etc/apache2/ports.conf  # change to Listen 3003

#OR
# Create a custom ports configuration
echo "Listen 3003" > /etc/apache2/conf-available/ports-3003.conf

# Enable the configuration
a2enconf ports-3003.conf
``` 

```bash
# Configure Virtual Host for Port 3003
vi /etc/apache2/sites-available/000-default.conf # update <VirtualHost 127.0.0.1:3003>
# OR create the conf file below
vi /etc/apache2/sites-available/000-default-3003.conf

# Disable default site if it conflicts (optional)
a2dissite 000-default.conf

# Enable your new configuration
a2ensite 000-default-3003.conf
```

```bash
# Run these commands inside the container
sed -i 's/Listen 80/Listen 80\nListen 3003/g' /etc/apache2/ports.conf
sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:80>\n<VirtualHost \*:3003>/g' /etc/apache2/sites-available/000-default.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/000-default.conf
service apache2 restart
```

c. Make sure Apache service is up and running inside the container. Keep the container in running state at the end.

```bash
# Test Apache configuration
apache2ctl configtest

# If you get "NameVirtualHost has no effect" warning, ignore it

# Restart Apache to apply changes
service apache2 restart
# or
systemctl restart apache2

# Check listening ports
netstat -tulpn | grep :3003
# or
ss -tulpn | grep :3003

# Check Apache status
service apache2 status

# Test with curl (from inside container)
apt install -y curl
curl http://localhost:3003
```

```text
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.12.0.2. Set the 'ServerName' directive globally to suppress this message
Syntax OK
```

```bash
docker commit kkloud kkloud_new_image
docker inspect kkloud | grep IPAddress # get the IPAddress of the container
curl http://172.12.0.2:3003
```
