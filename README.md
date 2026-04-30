[![Publish Docker image](https://github.com/techlotse/codestream-cloudcli/actions/workflows/container-build.yml/badge.svg)](https://github.com/techlotse/codestream-cloudcli/actions/workflows/container-build.yml)   [![Documentation](https://github.com/techlotse/codestream-cloudcli/actions/workflows/update-docs.yml/badge.svg)](https://github.com/techlotse/codestream-cloudcli/actions/workflows/update-docs.yml)

# CodeStream-CloudCLI

A lightweight, security-focused Docker container with essential cloud and infrastructure CLI tools for automation pipelines and CI/CD workflows.

## Docker Image

- **Image**: `techlotse/codestream-cloudcli`
- **Latest Tag**: `latest` or `v<version>` or `<YYYYMMDD>`
- **Base Image**: Alpine Linux 3.19 (lightweight & security-focused)
- **Last Updated**: See badges above for latest build status

## Installed Tools and Versions

| Tool | Version |
|------|---------|
| AWS CLI | Check GitHub Actions for latest |
| Azure CLI | Check GitHub Actions for latest |
| Terraform | Check GitHub Actions for latest |
| Packer | Check GitHub Actions for latest |
| Ansible | Check GitHub Actions for latest |
| yq | Check GitHub Actions for latest |
| jq | Check GitHub Actions for latest |

> **Note**: This README is auto-updated after each successful container build with actual version numbers. If you see placeholder text above, the README will be updated within minutes of the build completing.

## Additional Included Tools

- curl, wget, unzip
- git
- Python 3 with pip
- sed, awk (GNU AWK)
- CA certificates & OpenSSL
- make
- bind-tools (dns utilities)

## Usage

### Basic Usage

```bash
docker run -it techlotse/codestream-cloudcli:latest
```

### With AWS Credentials

```bash
docker run -it \
  -e AWS_ACCESS_KEY_ID=your_key \
  -e AWS_SECRET_ACCESS_KEY=your_secret \
  -e AWS_REGION=us-east-1 \
  techlotse/codestream-cloudcli:latest
```

### With Volume Mount

```bash
docker run -it \
  -v /path/to/your/code:/data \
  techlotse/codestream-cloudcli:latest
```

## Versioning

- **Semantic Versioning**: Images are tagged with semantic versions (v0.3.0, etc.)
- **Date Tags**: Images are also tagged with build dates (YYYYMMDD format)
- **Latest Tag**: Always points to the most recent stable build
- **Build Schedule**: Weekly builds on Sunday at 6:00 AM UTC

## Build and Push Schedule

This image is automatically built and pushed to Docker Hub:

- **Schedule**: Every Sunday at 6:00 AM UTC (7:00 AM CET)
- **Trigger**: Automated weekly schedule via GitHub Actions
- **Registry**: Docker Hub (techlotse/codestream-cloudcli)
- **Provenance**: SBOM and provenance data included with each build

## Documentation Updates

The README is automatically updated after each successful container build with the latest tool versions. Documentation updates do not trigger new container builds, ensuring a clean separation of concerns.

## Architecture

- **OS**: Alpine Linux 3.19
- **Container Runtime**: Compatible with Docker, Podman, containerd
- **Default Working Directory**: `/data`
- **Default Shell**: `/bin/bash`

## Building Locally

```bash
# Standard build
docker build -t codestream-cloudcli:local .

# Test the build
docker run -it codestream-cloudcli:local

# Inside container, verify tools
aws --version
terraform --version
packer --version
ansible --version
az --version
yq --version
jq --version
```

## Description

This repository contains the Dockerfile and automation scripts for building the CodeStream CloudCLI Docker image, used for managing cloud resources through various CLI tools. The container is optimized for use in automation pipelines, CI/CD systems, and infrastructure-as-code workflows.

## Support & Maintenance

Maintainer: TechLotse (info@techlotse.io)
Repository: github.com/techlotse/codestream-cloudcli
Registry: hub.docker.com/r/techlotse/codestream-cloudcli

For issues or questions, please refer to the repository or contact the maintainer.
