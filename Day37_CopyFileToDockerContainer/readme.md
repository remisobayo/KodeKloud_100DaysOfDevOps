

# Day 37 - Copy File to Docker Container
- 12/22/2025

- The most important thing to do in solving a problem is to begin.
– Frank Tyger

- People who are really serious about software should make their own hardware.
– Alan Kay

The Nautilus DevOps team possesses confidential data on App Server 2 in the Stratos Datacenter. A container named ubuntu_latest is running on the same server.

Copy an encrypted file /tmp/nautilus.txt.gpg from the docker host to the ubuntu_latest container located at /usr/src/. Ensure the file is not modified during this operation.

server - ssh steve@stapp02

# Method 1: Copy the encrypted file to the container
```bash
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/usr/src/
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/usr/src/nautilus.txt.gpg

docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/opt/
```

# Method 2: Create a temporary container with volume mount
```bash
docker run -it --rm \
  -v /tmp:/host-tmp \
  -v $(pwd):/usr/src \
  ubuntu:latest \
  cp /host-tmp/nautilus.txt.gpg /usr/src/
```

# Method 3: Copy the file
```bash
docker cp /tmp/nautilus.txt.gpg $(docker ps -qf "name=ubuntu_latest"):/usr/src/
```

# Method 4: Using exec with cat
```bash
docker exec ubuntu_latest bash -c 'cat > /usr/src/nautilus.txt.gpg' < /tmp/nautilus.txt.gpg
```


# Check if file exists
```bash
docker exec ubuntu_latest ls -la /usr/src/nautilus.txt.gpg
docker exec ubuntu_latest ls -la /opt/
```

# Check file size/md5
```bash
docker exec ubuntu_latest stat /usr/src/nautilus.txt.gpg
docker exec ubuntu_latest md5sum /usr/src/nautilus.txt.gpg
```