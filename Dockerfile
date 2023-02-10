FROM amazonlinux
#
# Identify the maintainer of an image
LABEL maintainer="info@techlotse.io"
LABEL version="0.0.5"

# Set Packer Version 
ENV PACKER_VER=1.8.5

# Install Pre-Requisites
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo 
RUN yum -y update && \
    yum -y upgrade && \
    yum install -y curl wget unzip git ca-certificates openssl jq python3 make yum-utils

# Install Packer
RUN wget -q https://releases.hashicorp.com/packer/${PACKER_VER}/packer_${PACKER_VER}_linux_amd64.zip && \
    unzip packer_${PACKER_VER}_linux_amd64.zip && \
    mv -f packer /usr/local/bin/ && \
    rm packer_${PACKER_VER}_linux_amd64.zip

# Install AWS CLI
RUN python3 -m pip install awscli ansible azure-cli
    
# Install Ansible
#RUN python3 -m pip install ansible

# Install Azure CLI
#RUN python3 -m pip install azure-cli

# Install Terraform
#RUN yum -y install terraform

#Cleanups
RUN yum clean all && \
    rm -rf /var/cache/yum/* && \
    rm -rf /var/cache/apk/*
