FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    curl \
    wget \
    git \
    apache2 

RUN sed -i 's/Listen 80/Listen 6100/g' /etc/apache2/ports.conf
WORKDIR /app

CMD ["/bin/bash"]