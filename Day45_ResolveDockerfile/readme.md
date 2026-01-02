

# Day 45 - Resolve Dockerfile Issues
- 01/01/2026
You are never too old to set another goal or to dream a new dream.
– Malala Yousafzai

All you need is the plan, the road map, and the courage to press on to your destination.
– Earl Nightingale

The Nautilus DevOps team is working to create new images per requirements shared by the development team. One of the team members is working to create a Dockerfile on App Server 2 in Stratos DC. While working on it she ran into issues in which the docker build is failing and displaying errors. Look into the issue and fix it to build an image as per details mentioned below:

a. The Dockerfile is placed on App Server 2 under /opt/docker directory.

b. Fix the issues with this file and make sure it is able to build the image.

c. Do not change base image, any other valid configuration within Dockerfile, or any of the data been used — for example, index.html.

Note: Please note that once you click on FINISH button all the existing containers will be destroyed and new image will be built from your Dockerfile.

Server - ssh steve@stapp02

```bash
sudo docker build /opt/docker/Dockerfile  # gave error 

cd /opt/docker/
sudo vi /opt/docker/Dockerfile
docker build -t class-apache .
docker images

docker run -d -p 80:8080 --name apache-server class-apache:latest

docker ps -a
# Check if Apache is running
curl http://localhost:80
```

-- Errors
```text
[steve@stapp02 ~]$ sudo docker build /opt/docker/Dockerfile
[+] Building 0.0s (0/0)                       docker:default
ERROR: failed to build: unable to prepare context: path "/opt/docker/Dockerfile" not found
```

```text
Dockerfile:3
--------------------
   1 |     FROM httpd:2.4.43
   2 |     
   3 | >>> ADD sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.conf
   4 |     
   5 |     ADD sed -i '/LoadModule\ ssl_module modules\/mod_ssl.so/s/^#//g' conf/httpd.conf
--------------------
ERROR: failed to build: failed to solve: failed to process "\"s/Listen": unexpected end of statement while looking for matching double-quote
```

```text
Wrong Dockerfile instruction: ADD is for copying files from host to container, not for running commands

Missing RUN: Commands should be executed with RUN

Escaping issues: The backslashes might cause problems in Dockerfile parsing

File path: The file path should be absolute or relative to WORKDIR
```