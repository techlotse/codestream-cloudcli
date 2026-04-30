# Dockerfile Implementation Notes

## Overview

The Dockerfile has been optimized for Alpine Linux 3.19 with a pragmatic approach to tool installation.

## Tool Installation Strategy

### Tools Available in Alpine Repositories
- **AWS CLI** - via `apk add aws-cli`
- **Azure CLI** - via `pip install azure-cli`
- **Ansible** - via `pip install ansible`
- **yq** - via `apk add yq`
- **jq** - via `apk add jq`
- **sed, awk** - Part of Alpine base image
- **curl, wget, unzip, git, etc.** - via `apk add`

### Tools Downloaded from HashiCorp Releases (Official Binaries)
- **Terraform** - Downloaded from https://releases.hashicorp.com/terraform/
- **Packer** - Downloaded from https://releases.hashicorp.com/packer/

**Why?** Alpine Linux doesn't include Terraform and Packer in its standard repositories. Using official HashiCorp binaries ensures:
- Latest stable versions always available
- Official binaries (verified and tested by HashiCorp)
- No dependency on third-party package maintainers
- Flexibility to update versions independently

## Build Process

The Dockerfile uses a smart versioning approach:

```dockerfile
# Get latest Terraform version from GitHub API
TERRAFORM_VERSION=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d'"' -f4 | sed 's/v//')

# Download from official HashiCorp releases
curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Same pattern for Packer
```

**Benefits:**
- Always gets the latest stable release
- No hardcoded version numbers
- Automatic updates on every rebuild
- Transparent and auditable

## Image Contents

### Base
- Alpine Linux 3.19 (~5MB)
- Essential build tools (curl, wget, make, git, etc.)

### CLI Tools (9 total)
```
✓ AWS CLI v2
✓ Azure CLI (latest)
✓ Terraform (latest from HashiCorp)
✓ Packer (latest from HashiCorp)
✓ Ansible (latest)
✓ yq
✓ jq
✓ sed
✓ awk (GNU AWK)
```

### Additional Tools
- Python 3 with pip
- OpenSSL & CA certificates
- bind-tools (DNS utilities)
- bash shell
- And more...

## Version Tracking

The Dockerfile creates `/etc/cloudcli-versions.txt` inside the container with version information:

```bash
docker run --rm techlotse/codestream-cloudcli cat /etc/cloudcli-versions.txt
```

Output will show:
```
CloudCLI Version Information:
AWS CLI: 2.x.x
Terraform: v1.x.x
Packer: v1.x.x
Ansible: 2.x.x
Azure CLI: x.x.x
yq: 4.x.x
jq: 1.x
```

## Building Locally

```bash
# Standard build
docker build -t codestream-cloudcli:local .

# Build with specific base image
docker build --build-arg FROM=alpine:latest -t codestream-cloudcli:custom .

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

## Layer Optimization

The Dockerfile is structured to optimize Docker layer caching:

1. **Base system packages** - Most stable, cached longest
2. **AWS CLI** - System package, stable
3. **Terraform & Packer** - Downloaded binaries, can change frequently
4. **Python packages** - pip install (Ansible, Azure CLI)
5. **Version file** - Always generated, forces cache invalidation

This means:
- System packages cached unless `apk` changes
- GitHub API calls for Terraform/Packer happen when explicitly needed
- Version info always reflects latest installed versions

## Size Considerations

- Base Alpine: ~5 MB
- Tools + dependencies: ~300-400 MB (depending on Python packages)
- Final image: ~400-500 MB total

This is significantly smaller than the original Amazon Linux 2023 image (~200+ MB base + tools).

## Security Notes

- **Alpine Linux** is security-focused and regularly updated
- **Official binaries** from HashiCorp (verified, signed releases)
- **Minimal attack surface** - only essential tools included
- **Latest versions** - always pulling latest stable releases
- **No vulnerability-prone older versions** retained

## Troubleshooting

### If Terraform/Packer download fails
- Check internet connectivity
- Verify HashiCorp releases are accessible
- Check GitHub API rate limits
- Manual fallback: Pin specific versions in Dockerfile

### If pip packages fail
- Check Python 3 compatibility
- Verify pip and setuptools are current
- Check package availability for Alpine

### To use specific versions (instead of latest)

Edit Dockerfile and replace:
```dockerfile
# For Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip

# For Packer
RUN curl -fsSL https://releases.hashicorp.com/packer/1.9.0/packer_1.9.0_linux_amd64.zip
```

## Future Improvements

Possible optimizations:
1. Multi-stage builds to reduce final image size
2. Caching downloaded binaries externally
3. Running security scans (Trivy, Grype)
4. SBOMs and attestations (already in GitHub Actions)

## References

- Alpine Linux: https://alpinelinux.org/
- HashiCorp Releases: https://releases.hashicorp.com/
- AWS CLI: https://aws.amazon.com/cli/
- Azure CLI: https://learn.microsoft.com/cli/azure/
- Terraform: https://www.terraform.io/
- Packer: https://www.packer.io/
- Ansible: https://www.ansible.com/
- yq: https://github.com/mikefarah/yq
- jq: https://stedolan.github.io/jq/

---

**Last Updated**: April 30, 2026
**Version**: 0.3.0
**Status**: Ready for Production
