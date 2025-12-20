
# Day 36 - Deploy Nginx Container
- 12/17/2025
Hard work beats talent when talent doesn’t work hard.
– Tim Notke

The Nautilus DevOps team is conducting application deployment tests on selected application servers. They require a nginx container deployment on Application Server 1. Complete the task with the following instructions:
- On Application Server 1 create a container named nginx_1 using the nginx image with the alpine tag. Ensure container is in a running state.

server - ssh tony@stapp01
```text
Summary
docker run  (docker command to run the container)
-d - run as a daemon in the background
--name - the name of the container to be created
-p HostPort:ContainerPort
nginx:alpine - the name of the image to pull and the tag.

```

```bash
sudo systemctl status docker
# docker pull nginx:alpine
docker run -d --name nginx_1 nginx:alpine # -p 80:80
docker run -d --name nginx_1 -p 8080:80 nginx:alpine

docker stop nginx_1
docker rm nginx_1
```

- Verify that the container is running

```bash
docker ps
docker ps -a # to view all 
docker inspect nginx_1
```

```text
[tony@stapp01 ~]$ docker inspect nginx_1
[
    {
        "Id": "30fe93e64def1d6d17fca7d6d0d764b417bf7995c2fcf112eb0c9daa915f5c31",
        "Created": "2025-12-17T06:32:59.817030853Z",
        "Path": "/docker-entrypoint.sh",
        "Args": [
            "-p",
            "80:80"
        ],
        "State": {
            "Status": "exited",
            "Running": false,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 0,
            "ExitCode": 2,
            "Error": "",
            "StartedAt": "2025-12-17T06:33:01.210691922Z",
            "FinishedAt": "2025-12-17T06:33:01.216788443Z"
        }, ...
```

- Check the logs

```bash
docker logs nginx_1
```

```text
[tony@stapp01 ~]$ docker logs nginx_1
/docker-entrypoint.sh: exec: line 47: illegal option -p
```

```bash
docker ps -f "name=nginx_1"
```


