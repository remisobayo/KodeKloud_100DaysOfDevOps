

# Day 39 - Create a Docker Image From Container
- 12/23/2025

- Tell me and I forget. Teach me and I remember. Involve me and I learn.
– Benjamin Franklin

One of the Nautilus developer was working to test new changes on a container. He wants to keep a backup of his changes to the container. A new request has been raised for the DevOps team to create a new image from this container. Below are more details about it:

a. Create an image apps:datacenter on Application Server 3 from a container ubuntu_latest that is running on same server.


server - ssh banner@stapp03

```bash
docker commit \
  --author "Your Name" \
  --message "Description of changes" \
  container_name \
  image_name:tag

# Export container to a tarball
docker export container_name > container.tar

# Import tarball as a new image
docker import container.tar new_image_name:tag  

# 1. Run a container and make changes
docker run -it --name temp_container ubuntu:latest /bin/bash
docker exec -it ubuntu_latest "/bin/bash"
# Inside container: apt update && apt install -y nginx

# actual commands
docker commit ubuntu_latest apps:datacenter
docker ps -a
docker images
```

```text
[banner@stapp03 ~]$ docker images
REPOSITORY   TAG          IMAGE ID       CREATED          SIZE
apps         datacenter   d393138008d1   15 seconds ago   135MB
ubuntu       latest       c3a134f2ace4   2 months ago     78.1MB
```

```text
Press Ctrl+P (release)
Press Ctrl+Q (release)

docker exec -it --detach-keys="ctrl-d" container_name /bin/bash

Then use Ctrl+D to detach.
```