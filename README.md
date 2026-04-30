[![Publish Docker image](https://github.com/techlotse/codestream-cloudcli/actions/workflows/container-build.yml/badge.svg)](https://github.com/techlotse/codestream-cloudcli/actions/workflows/container-build.yml)   [![Documentation](https://github.com/techlotse/codestream-cloudcli/actions/workflows/update-docs.yml/badge.svg)](https://github.com/techlotse/codestream-cloudcli/actions/workflows/update-docs.yml)

# CodeStream-CloudCLI

A lightweight, security-focused Docker container with essential cloud and infrastructure CLI tools for automation pipelines and CI/CD workflows.

## Docker Image

- **Image**: `techlotse/codestream-cloudcli`
- **Latest Tag**: `latest` or `v<version>` or `<YYYYMMDD>`
- **Base Image**: Alpine Linux 3.19 (lightweight & security-focused)
- **Last Updated**: Check GitHub Actions workflow logs

## Installed Tools and Versions

| Tool | Purpose |
|------|---------|
| AWS CLI | Amazon Web Services command-line interface |
| Azure CLI | Microsoft Azure command-line interface |
| Terraform | Infrastructure-as-Code provisioning |
| Packer | Machine image creation & management |
| Ansible | Configuration management & automation |
| yq | YAML/JSON query and manipulation |
| jq | JSON processor and query tool |

## Additional Included Tools

- **curl**, wget, unzip
- git
- Python 3 with pip
- sed, awk (GNU AWK)
- CA certificates & OpenSSL
- make
- bind-tools (DNS utilities)

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

## Versioning Strategy

- **Semantic Versioning**: Images tagged with versions like `v0.3.0`
- **Date-based Tags**: Images also tagged with build dates in `YYYYMMDD` format
- **Latest Tag**: Always points to the most recent stable build
- **Build Frequency**: Weekly automated builds (Sundays at 6:00 AM UTC)

## Build Automation

### Weekly Build Schedule

This image is automatically built and pushed to Docker Hub:
- **Schedule**: Every Sunday at 6:00 AM UTC (7:00 AM CET)
- **Trigger**: Automated weekly schedule via GitHub Actions
- **Registry**: Docker Hub at `techlotse/codestream-cloudcli`
- **Provenance**: SBOM and provenance data included with each build

### Documentation Updates

- README is automatically updated after each successful container build
- Tool versions are extracted from the running container
- Documentation commits include `[skip ci]` to prevent triggering new builds
- Separation of concerns: Docs updates ≠ Container builds

## Building Locally

### Build with default settings

```bash
docker build -t codestream-cloudcli:local .
```

### Build with custom tool versions

```bash
docker build \
  --build-arg TERRAFORM_VER=1.5.0 \
  --build-arg PACKER_VER=1.9.0 \
  -t codestream-cloudcli:custom .
```

## Image Security

- **Minimal Base**: Alpine Linux 3.19 (~5MB base image)
- **Security-Focused**: Alpine is designed for container environments
- **Reduced Attack Surface**: Only essential tools included
- **No Root Requirement**: Run as non-root user when possible

## Maintenance & Updates

The container is automatically updated weekly with the latest versions of all included tools. The build process:

1. Pulls latest tool versions from official repositories
2. Builds the Docker image
3. Pushes to Docker Hub with version tags
4. Updates README with extracted version information
5. Creates SBOM and provenance attestations

## Architecture

- **OS**: Alpine Linux 3.19
- **Container Runtime**: Compatible with Docker, Podman, containerd
- **Default Working Directory**: `/data`
- **Default Shell**: `/bin/bash`

## Contributing

For updates, bug reports, or feature requests, please open an issue or pull request in the repository.

## License

Maintained by TechLotse ([info@techlotse.io](mailto:info@techlotse.io))
