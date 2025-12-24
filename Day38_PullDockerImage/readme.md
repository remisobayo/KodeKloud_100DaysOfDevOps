

# Day 38 - Pull Docker Image
- 12/22/2025
For success attitude is equally important as ability.
– Harry F.Bank

Nautilus project developers are planning to start testing on a new project.As per their meeting with the DevOps team, they want to test containerized environment application features. As per details shared with DevOps team, we need to accomplish the following task:
a. Pull busybox:musl image on App Server 2 in Stratos DC and re-tag (create new tag) this image as busybox:media.

server - ssh steve@stapp02

```bash
# docker tag source:latest target:v1
# docker tag a1b2c3d4e5f6 myapp:newtag

docker ps -a
docker images
docker pull busybox:musl 
docker images
docker tag busybox:musl busybox:media
docker images
```