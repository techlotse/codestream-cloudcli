FROM amazonlinux
#
# Identify the maintainer of an image
LABEL maintainer="info@techlotse.io"
LABEL version="0.0.2"

# Set Packer Version 
ENV PACKER_VER=1.8.2

# Install Pre-Requisites
RUN yum -y update && \
    yum -y upgrade && \
    yum install -y curl wget unzip git ca-certificates openssl jq python3 make

# Install Packer
RUN wget -q https://releases.hashicorp.com/packer/${PACKER_VER}/packer_${PACKER_VER}_linux_amd64.zip && \
    unzip packer_${PACKER_VER}_linux_amd64.zip && \
    mv -f packer /usr/local/bin/ 

# Install AWS CLI
RUN pip3 install --upgrade pip && \
    pip3 install \
    awscli 
    
# Install Ansible
RUN python3 -m pip install ansible

#Cleanups
RUN yum -y update && \
    yum -y upgrade && \
    yum clean all && \
    rm -rf /var/cache/yum/* && \
    rm -rf /var/cache/apk/*
