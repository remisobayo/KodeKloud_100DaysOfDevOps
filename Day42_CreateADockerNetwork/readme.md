

# Day 42 - Create a Docker Network
- 12/27/2025
- The most important thing to do in solving a problem is to begin.
– Frank Tyger


Those who hoard gold have riches for a moment.
Those who hoard knowledge and skills have riches for a lifetime.
– The Diary of a CEO

The Nautilus DevOps team needs to set up several docker environments for different applications. One of the team members has been assigned a ticket where he has been asked to create some docker networks to be used later. Complete the task based on the following ticket description:
a. Create a docker network named as official on App Server 1 in Stratos DC.
b. Configure it to use macvlan drivers.
c. Set it to use subnet 10.10.1.0/24 and iprange 10.10.1.0/24.

Server - ssh tony@stapp01

```bash
docker network create \
  --driver macvlan \
  --subnet=10.10.1.0/24 \
  --ip-range=10.10.1.0/24 \
  # --gateway=172.28.5.254 \
  # --label "environment=production" \
  official

# 
docker network create \
  --driver macvlan \
  --subnet=192.168.0.0/24 \
  --ip-range=192.168.0.0/24 \
  news 
```

- Verify the network
```bash
# List all networks
docker network ls

# Inspect the 'official' network details
docker network inspect official
```

- Connect a container to the network
```bash
# Run a container attached to the 'official' network
docker run -d --name myapp --network official nginx

# Connect an existing container to the network
docker network connect official existing-container

# Create a container with multiple networks
docker run -d --name app \
  --network official \
  --network another-network \
  myimage
```

- Remove the network
```bash
# Remove the network (only if no containers are attached)
docker network rm official

# Force remove (disconnects all containers first)
docker network rm -f official
```

```text
1. Custom network provides isolation of containers.
2. Custom network provides automatic DNS resolution

# On custom network: can ping by container name
docker network create mynet
docker run -d --network mynet --name web nginx
docker run -it --network mynet alpine ping web  # Works!

# On default bridge: only IP works
docker run -d --name web nginx
docker run -it alpine ping web  # Fails! Must use IP address

3. Improves security - you can separate the networks of apps, backend and database.
# Separate tiers of your application
docker network create frontend-net
docker network create backend-net
docker network create database-net

# Only connect containers to networks they need
docker run --network frontend-net --name frontend nginx
docker run --network backend-net --name backend api-server
docker run --network database-net --name database postgres

# Then connect selectively
docker network connect backend-net frontend  # Only if needed

4. Multi-container applications (microservices)
# Docker Compose automatically creates networks
version: '3'
services:
  web:
    image: nginx
    networks:
      - frontend
  api:
    image: node
    networks:
      - frontend
      - backend
  db:
    image: postgres
    networks:
      - backend

networks:
  frontend:
  backend:

5. Custom networks provide network configuration control
# Custom IP ranges, subnets, and gateways
docker network create \
  --subnet=10.10.0.0/16 \
  --gateway=10.10.0.1 \
  --ip-range=10.10.1.0/24 \
  production-net


You should create custom Docker networks whenever you have multiple containers that need controlled communication, especially for production applications, microservices architectures, or when you need network-level security isolation.

```