
# Day 35: Install Docker Packages and Start Docker Service
- 12/16/2025

- One big reason for a winning attitude is that you will take the necessary steps and not quit when the going gets difficult.
– Don M.Green

The Nautilus DevOps team aims to containerize various applications following a recent meeting with the application development team. They intend to conduct testing with the following steps:
- Install docker-ce and docker compose packages on App Server 2.
- Initiate the docker service.


Server - ssh steve@stapp02

- Install using the rpm repository 
(visit docker documentation - https://docs.docker.com/engine/install/centos/)

```bash
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker # start docker automatically when you boot the system.
# OR
sudo systemctl start docker
sudo docker run hello-world

```