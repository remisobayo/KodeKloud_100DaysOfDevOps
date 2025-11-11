# Day 16: Install and Configure Nginx as an LBR
# https://nginx.org/en/docs/http/request_processing.html

# Install nginx
```bash
sudo yum install epel-release
sudo yum install nginx
```
# Edit the configuration file on the LBR server
`sudo vi /etc/nginx/nginx.conf`

# Add the following configuration
http {
    upstream app_backend {
        least_conn;
        server 172.16.238.10:5004 weight=3 max_conns=100;
        server 172.16.238.11:5004 weight=2;
        server 172.16.238.12:5004 weight=1;
    }

    server {
        listen 80;
        # listen [::]:80 default_server;
        server_name stlb01.stratos.xfusioncorp.com;
        
        # Application routes
        location /api/ {
            proxy_pass http://app_backend;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
            
            # # Timeouts
            # proxy_connect_timeout 5s;
            # proxy_send_timeout 15s;
            # proxy_read_timeout 15s;
            
            # # Retry logic
            # proxy_next_upstream error timeout http_500 http_502 http_503 http_504;
            # proxy_next_upstream_tries 2;
        }
        
        # Load balancer status page
        # location /nginx_status {
        #     stub_status on;
        #     access_log off;
        #     allow 127.0.0.1;
        #     allow 10.0.0.0/8;
        #     deny all;
        # }
    }
}

# check the conf file and start the service
```bash
sudo nginx -t
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl reload nginx
curl http://localhost/nginx_status
```

# check the application service on the app servers
# apache is httpd.service
`ps -ef | grep httpd`

# check if httpd is running and what port it is using
```bash
sudo systemctl status httpd
sudo systemctl enable httpd
sudo systemctl start httpd
```

# On the App Servers: check what port httpd service is running
```bash
sudo netstat -tulpn | grep httpd
sudo ss -tulpn | grep httpd
sudo lsof -i -P | grep httpd
```
# httpd is using port 5004, 5002, 6300

# Testing the application locally on each app server
`curl http://localhost:6300`

# Testing the application on the LBR server
`curl -H "Host: stlb01.stratos.xfusioncorp.com" http://localhost/`
172.16.238.14 # LBR server IP

# checking the logs
```bash
sudo tail -n 20 /var/log/nginx/error.log
tail -f /var/log/nginx/access.log
```
error_log /var/log/nginx/error.log;
access log - /var/log/nginx/access.log


# Errors
Nov 01 06:52:04 stlb01.stratos.xfusioncorp.com systemd[1]: nginx.service: Failed to send unit change signal for nginx.service: Connection reset by peer