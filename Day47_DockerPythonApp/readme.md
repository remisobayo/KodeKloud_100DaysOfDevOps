
# Day 47 - Docker Python App
- 01/06/2025

Those who hoard gold have riches for a moment.
Those who hoard knowledge and skills have riches for a lifetime.
– The Diary of a CEO

A python app needed to be Dockerized, and then it needs to be deployed on App Server 3. We have already copied a requirements.txt file (having the app dependencies) under /python_app/src/ directory on App Server 3. Further complete this task as per details mentioned below:

Create a Dockerfile under /python_app directory:
    Use any python image as the base image.
    Install the dependencies using requirements.txt file.
    Expose the port 5002.
    Run the server.py script using CMD.

Build an image named nautilus/python-app using this Dockerfile.

Once image is built, create a container named pythonapp_nautilus:

Map port 5002 of the container to the host port 8094.

Once deployed, you can test the app using curl command on App Server 3.

curl http://localhost:8094/

Server - ssh banner@stapp03


```bash
cd /python_app
ls -al /python_app/src/
sudo docker build -t nautilus/python-app .

# sudo docker rm pythonapp_nautilus
sudo docker run -d -p 8094:5002 --name pythonapp_nautilus nautilus/python-app

docker exec -it --detach-keys="ctrl-d" pythonapp_nautilus /bin/bash
curl http://localhost:8094/

# validation
sudo docker ps -a
sudo docker images

```

```text
- Directory structure
/python_app/
├── Dockerfile
└── src/
    ├── requirements.txt
    └── server.py

```

```text
[banner@stapp03 ~]$ docker images
REPOSITORY            TAG       IMAGE ID       CREATED          SIZE
nautilus/python-app   latest    f94746080c01   10 minutes ago   140MB

```