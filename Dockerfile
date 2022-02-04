FROM amazonlinux
#
# Identify the maintainer of an image
LABEL maintainer="info@techlotse.io"
LABEL version="0.0.1"

# Set Packer Version 
ENV PACKER_VER=1.6.2

# Install Pre-Requisites
RUN yum -y update && \
    yum -y upgrade && \
    yum install -y curl wget unzip git ca-certificates openssl jq python3 make && \
    yum clean all

# Install Packer
RUN wget -q https://releases.hashicorp.com/packer/${PACKER_VER}/packer_${PACKER_VER}_linux_amd64.zip && \
    unzip packer_${PACKER_VER}_linux_amd64.zip && \
    mv -f packer /usr/local/bin/ 

# Install AWS CLI
RUN pip3 install --upgrade pip && \
    pip3 install \
    awscli \
    && rm -rf /var/cache/apk/*
