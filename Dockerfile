FROM amazonlinux
#
# Identify the maintainer of an image
LABEL maintainer="info@techlotse.io"
LABEL version="0.1.0"

# Set Packer Version 
ENV PACKER_VER=1.10.0

# Install Pre-Requisites
 
RUN dnf -y update && \
    dnf -y upgrade && \
    dnf install -y curl wget unzip git ca-certificates openssl jq python3 make dnf-utils
RUN dnf-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo && \
    dnf -y update && \
    dnf -y upgrade

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
#RUN dnf -y install terraform

#Cleanups
RUN dnf clean all && \
    rm -rf /var/cache/dnf/* && \
    rm -rf /var/cache/apk/*
