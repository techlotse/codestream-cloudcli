# CodeStream-CloudCLI

A lightweight, security-focused Docker container with essential cloud and infrastructure CLI tools for automation pipelines and CI/CD workflows.

## Docker Image

- Image: techlotse/codestream-cloudcli
- Latest Tag: latest or v<version> or YYYYMMDD
- Base Image: Alpine Linux 3.19 (lightweight & security-focused)
- Image Digest: $DOCKER_IMAGE_VERSION
- Last Updated: $BUILD_DATE

## Installed Tools and Versions

| Tool | Version |
|------|---------|
| AWS CLI | $AWS_CLI_VERSION |
| Azure CLI | $AZURE_CLI_VERSION |
| Terraform | $TERRAFORM_VERSION |
| Packer | $PACKER_VERSION |
| Ansible | $ANSIBLE_VERSION |
| yq | $YQ_VERSION |
| jq | $JQ_VERSION |

## Additional Included Tools

- curl, wget, unzip
- git
- Python 3 with pip
- sed, awk (GNU AWK)
- CA certificates & OpenSSL
- make
- bind-tools (dns utilities)

## Usage

Basic usage:

```bash
docker run -it techlotse/codestream-cloudcli:latest
```

## Versioning

- Semantic Versioning: Images are tagged with semantic versions
- Date Tags: Images are also tagged with build dates (YYYYMMDD format)
- Latest Tag: Always points to the most recent stable build
- Build Schedule: Weekly builds on Sunday at 6:00 AM UTC

## Build and Push Schedule

This image is automatically built and pushed to Docker Hub:

- Schedule: Every Sunday at 6:00 AM UTC (7:00 AM CET)
- Trigger: Automated weekly schedule via GitHub Actions
- Registry: Docker Hub (techlotse/codestream-cloudcli)

## Documentation Updates

The README is automatically updated after each successful container build with the latest tool versions. Documentation updates do not trigger new container builds, ensuring clean separation of concerns.

## Description

This repository contains the Dockerfile and automation scripts for building the CodeStream CloudCLI Docker image, used for managing cloud resources through various CLI tools.
