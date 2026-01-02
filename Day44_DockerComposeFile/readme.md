
# Day 44 - Write a Docker Compose File
- 12/31/2025

You don't get what you wish for. You get what you work for.
– Daniel Milstein

One big reason for a winning attitude is that you will take the necessary steps and not quit when the going gets difficult.
– Don M.Green

The Nautilus application development team shared static website content that needs to be hosted on the httpd web server using a containerised platform. The team has shared details with the DevOps team, and we need to set up an environment according to those guidelines. Below are the details:

a. On App Server 3 in Stratos DC create a container named httpd using a docker compose file /opt/docker/docker-compose.yml (please use the exact name for file).

b. Use httpd (preferably latest tag) image for container and make sure container is named as httpd; you can use any name for service.

c. Map 80 number port of container with port 3002 of docker host.

d. Map container's /usr/local/apache2/htdocs volume with /opt/finance volume of docker host which is already there. (please do not modify any data within these locations).

server - ssh banner@stapp03

```bash
sudo vi /opt/docker/docker-compose.yml
ls /opt/finance
sudo rm /opt/docker/.docker-compose.yml.swp # remove the swp file
# check the sample docker-compose.yml file in this directory.
```

```bash
# running the container
cd /opt/docker
docker compose up -d
docker compose ps
# or
docker ps | grep httpd
curl http://localhost:3002
# or visit http://your-server-ip:3002 in a browser
```


```text
[banner@stapp03 docker]$ docker compose up -d
WARN[0000] /opt/docker/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
[+] Running 7/7
 ✔ web Pulled                                                 5.9s 
   ✔ 02d7611c4eae Pull complete                               2.6s 
   ✔ 5a84161993ab Pull complete                               2.9s 
   ✔ 4f4fb700ef54 Pull complete                               3.2s 
   ✔ 8eb44842f200 Pull complete                               3.9s 
   ✔ b5be9d562803 Pull complete                               5.1s 
   ✔ af0709a53cc2 Pull complete                               5.7s 
[+] Running 2/2
 ✔ Network docker_default  Create...                          0.1s 
 ✔ Container httpd         Started                            1.7s
 ```