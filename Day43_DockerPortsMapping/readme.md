

# Day 43 - Docker Ports Mapping
- 12/28/2025

Be not in despair, the way is very difficult, like walking on the edge of a razor; yet despair not, arise, awake, and find the ideal, the goal.
– Swami Vivekananda

I can and I will. Watch me.
– Carrie Green

The Nautilus DevOps team is planning to host an application on a nginx-based container. There are number of tickets already been created for similar tasks. One of the tickets has been assigned to set up a nginx container on Application Server 1 in Stratos Datacenter. Please perform the task as per details mentioned below:

a. Pull nginx:stable docker image on Application Server 1.

b. Create a container named ecommerce using the image you pulled.

c. Map host port 3000 to container port 80. Please keep the container in running state.

```bash
docker images
docker pull nginx:stable

docker run --name ecommerce -d -p 3000:80 nginx:stable
```

- verify that the container is running
```bash
# Check container status
docker ps

# View logs
docker logs ecommerce

# Test in browser
curl http://localhost:3000
# Or open http://localhost:3000 in your web browser
```