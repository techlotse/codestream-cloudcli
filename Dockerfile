# Start with Amazon Linux 2023 as the base image
FROM amazonlinux:2023

# Metadata as key/value label pairs
LABEL maintainer="info@techlotse.io"
LABEL version="0.2.0"

# Set environment variables for tool versions, defaulting to latest
# For specific versions, you can pass --build-arg PACKER_VER=<version> during docker build
ARG PACKER_VER=latest

# Install system updates and essential tools
RUN dnf -y update && \
    dnf -y install --allowerasing curl wget unzip git ca-certificates openssl jq python3 python3-pip make dnf-plugins-core && \
    dnf clean all && \
    rm -rf /var/cache/dnf/*

# Add HashiCorp's official repository and install Packer
# Note: If PACKER_VER is set to 'latest', ensure to handle version resolution appropriately
RUN dnf config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo && \
    if [ "$PACKER_VER" = "latest" ]; then \
        dnf -y install --allowerasing packer; \
    else \
        dnf -y install --allowerasing "packer-${PACKER_VER}"; \
    fi

# Install AWS CLI version 2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -f awscliv2.zip && \
    rm -rf aws

# Install AWS CLI, Ansible, and Azure CLI without cache to save space
RUN python3 -m pip install --no-cache-dir ansible azure-cli

# Install Terraform
RUN dnf -y install terraform

# Cleanup to reduce image size
RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

# Set the default working directory (optional)
WORKDIR /data

# Default command or entry point (optional)
CMD ["/bin/bash"]
