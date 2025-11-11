
# Install nginx
```bash
sudo yum install epel-release
sudo yum install nginx
```

# Start and enable nginx service
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
sudo nginx -t
```

# default nginx configuration file
`/etc/nginx/nginx.conf`
 
# Create SSL directory
`sudo mkdir -p /etc/nginx/ssl`

# Copy your certificate and key files
```bash
sudo cp /tmp/nautilus.crt /etc/nginx/ssl/
sudo cp /tmp/nautilus.key /etc/nginx/ssl/
```

# Set proper permissions
```bash
sudo chmod 600 /etc/nginx/ssl/nautilus.key
sudo chmod 644 /etc/nginx/ssl/nautilus.crt
sudo chown nginx:nginx /etc/nginx/ssl/nautilus.*
```

# Edit the configuration file
On CentOS; 
`sudo vi /etc/nginx/conf.d/stapp01.conf`

# Test configuration syntax
`sudo nginx -t`

# If test passes, reload Nginx
`sudo systemctl reload nginx`

# Check status
```bash
sudo systemctl status nginx
curl -Ik https://stapp01/
curl -Ik https://stapp01.stratos.xfusioncorp.com/
```

# to view the site content and ignore the certificate validation
curl -ik https://stapp01.stratos.xfusioncorp.com/
```bash
sudo echo "Welcome!" | sudo tee /usr/share/nginx/html/index.html
cat /usr/share/nginx/html/index.html

sudo ss -tulpn | grep :443
```
