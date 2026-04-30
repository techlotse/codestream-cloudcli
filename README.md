[![Publish Docker image](https://github.com/techlotse/codestream-cloudcli/actions/workflows/container-build.yml/badge.svg)](https://github.com/techlotse/codestream-cloudcli/actions/workflows/container-build.yml)   [![Documentation](https://github.com/techlotse/codestream-cloudcli/actions/workflows/update-docs.yml/badge.svg)](https://github.com/techlotse/codestream-cloudcli/actions/workflows/update-docs.yml)

# CodeStream-CloudCLI

A lightweight, security-focused Docker container with essential cloud and infrastructure CLI tools for automation pipelines and CI/CD workflows.

## Docker Image

- **Image**: `techlotse/codestream-cloudcli`
- **Latest Tag**: `latest` or `v<version>` or `<YYYYMMDD>`
- **Base Image**: Alpine Linux 3.19 (lightweight & security-focused)
- **Image Digest**: techlotse/codestream-cloudcli@sha256:3d63f5e9c97c9d0d1fb78174a48517a23e3cddb286fd20da3f0df7f99b73aa2e
- **Last Updated**: 2026-04-30T09:50:54Z

## Installed Tools and Versions

| Tool | Version |
|------|---------|
| AWS CLI | 2.15.14 |
| Azure CLI | 2.85.0 |
| Terraform | v1.15.0 |
| Packer | Packer v1.15.3 |
| Ansible | [core |
| yq | version |
| jq | jq-1.7.1 |

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

- **Semantic Versioning**: Images are tagged with semantic versions (v0.3.0, etc.)
- **Date Tags**: Images are also tagged with build dates (YYYYMMDD format)
- **Latest Tag**: Always points to the most recent stable build
- **Build Schedule**: Weekly builds on Sunday at 6:00 AM UTC

## Build and Push Schedule

This image is automatically built and pushed to Docker Hub:

- **Schedule**: Every Sunday at 6:00 AM UTC (7:00 AM CET)
- **Trigger**: Automated weekly schedule via GitHub Actions
- **Registry**: Docker Hub (techlotse/codestream-cloudcli)

## Documentation Updates

The README is automatically updated after each successful container build with the latest tool versions. Documentation updates do not trigger new container builds, ensuring a clean separation of concerns.

## Description

This repository contains the Dockerfile and automation scripts for building the CodeStream CloudCLI Docker image, used for managing cloud resources through various CLI tools. The container is optimized for use in automation pipelines, CI/CD systems, and infrastructure-as-code workflows.
