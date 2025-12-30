
# Day 41 - Write a Docker File
- 12/26/2025

The best way to guarantee a loss is to quit.
– Morgan Freeman

As per recent requirements shared by the Nautilus application development team, they need custom images created for one of their projects. Several of the initial testing requirements are already been shared with DevOps team. Therefore, create a docker file /opt/docker/Dockerfile (please keep D capital of Dockerfile) on App server 1 in Stratos DC and configure to build an image with the following requirements:

a. Use ubuntu:24.04 as the base image.
Server - ssh tony@stapp01

b. Install apache2 and configure it to work on 6100 port. (do not update any other Apache configuration settings like document root etc).

```text
The Basics of a Dockerfile

FROM
RUN
COPY
EXPOSE
CMD
ENTRYPOINT

```


```bash
# Build the image
docker build -t ubuntu-apache-6100 .

# Run the container
docker run -d -p 6100:6100 --name apache-server ubuntu-apache-6100

# Or run interactively for debugging
docker run -it --rm -p 6100:6100 ubuntu-apache-6100 bash

# Check if Apache is running
curl http://localhost:6100

# View logs
docker logs apache-server

# Stop and remove
docker stop apache-server
docker rm apache-server
```


```text
# Verify the installation
Access in browser: Open http://localhost:6100

Check with curl: curl -I http://localhost:6100

Check inside container: docker exec apache-server netstat -tulpn | grep 6100
```



```text
# Error while editing file
E325: ATTENTION
Found a swap file by the name "/var/tmp/Dockerfile.swp"
          owned by: tony   dated: Fri Dec 26 23:54:26 2025
         file name: /opt/docker/Dockerfile
          modified: YES
         user name: tony   host name: stapp01.stratos.xfusioncorp.com
        process ID: 2461 (STILL RUNNING)
While opening file "/opt/docker/Dockerfile"
      CANNOT BE FOUND
(1) Another program may be editing the same file.  If this is the case,
    be careful not to end up with two different instances of the same
    file when making changes.  Quit, or continue with caution.
(2) An edit session for this file crashed.
    If this is the case, use ":recover" or "vim -r /opt/docker/Dockerfile
"
    to recover the changes (see ":help recovery").
    If you did this already, delete the swap file "/var/tmp/Dockerfile.swp"
    to avoid this message.
"/opt/docker/Dockerfile" [New]
```

```text
Using swap file "/var/tmp/Dockerfile.swp"
"/opt/docker/Dockerfile" [New]
Recovery completed. You should check if everything is OK.
(You might want to write out this file under another name
and run diff with the original file to check for changes)
You may want to delete the .swp file now.
Note: process STILL RUNNING: 2461
```