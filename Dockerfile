# Start with Alpine Linux 3.19 - lightweight and security-focused base image
FROM alpine:3.19

# Metadata as key/value label pairs
LABEL maintainer="info@techlotse.io"
LABEL description="CloudCLI - Container with essential cloud and infrastructure CLI tools"

# Install system updates and essential tools
RUN apk add --no-cache \
    curl \
    wget \
    unzip \
    git \
    ca-certificates \
    openssl \
    python3 \
    py3-pip \
    make \
    bash \
    jq \
    yq \
    sed \
    gawk \
    bind-tools \
    && rm -rf /var/cache/apk/*

# Install AWS CLI version 2
RUN apk add --no-cache aws-cli

# Install Terraform from HashiCorp releases (download binary)
RUN TERRAFORM_VERSION=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d'"' -f4 | sed 's/v//') && \
    curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip && \
    unzip -o -q terraform.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform.zip && \
    terraform version

# Install Packer from HashiCorp releases (download binary)
RUN PACKER_VERSION=$(curl -s https://api.github.com/repos/hashicorp/packer/releases/latest | grep tag_name | cut -d'"' -f4 | sed 's/v//') && \
    curl -fsSL https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -o packer.zip && \
    unzip -o -q packer.zip && \
    mv packer /usr/local/bin/ && \
    rm packer.zip && \
    packer version

# Install Ansible and Azure CLI via pip without cache to save space
RUN python3 -m pip install --no-cache-dir --break-system-packages \
    ansible \
    azure-cli

# Create a version file for reference
RUN echo "CloudCLI Version Information:" > /etc/cloudcli-versions.txt && \
    echo "AWS CLI: $(aws --version 2>&1 || echo 'not installed')" >> /etc/cloudcli-versions.txt && \
    echo "Terraform: $(terraform version 2>&1 | head -1 || echo 'not installed')" >> /etc/cloudcli-versions.txt && \
    echo "Packer: $(packer version 2>&1 || echo 'not installed')" >> /etc/cloudcli-versions.txt && \
    echo "Ansible: $(ansible --version 2>&1 | head -1 || echo 'not installed')" >> /etc/cloudcli-versions.txt && \
    echo "Azure CLI: $(az version 2>&1 | head -1 || echo 'not installed')" >> /etc/cloudcli-versions.txt && \
    echo "yq: $(yq --version 2>&1 || echo 'not installed')" >> /etc/cloudcli-versions.txt && \
    echo "jq: $(jq --version 2>&1 || echo 'not installed')" >> /etc/cloudcli-versions.txt

# Set the default working directory
WORKDIR /data

# Default command or entry point
CMD ["/bin/bash"]
