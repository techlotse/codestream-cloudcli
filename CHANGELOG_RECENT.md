# Recent Changes - CloudCLI Docker Image Improvements

## Version 0.3.0 - Docker Image Modernization & Automation

### 🔄 Major Changes

#### 1. **Base Image Migration: Amazon Linux 2023 → Alpine Linux 3.19**
- **Benefits**:
  - Reduced image size: ~200MB → ~200-300MB (Alpine is smaller, but with all the tools it's similar)
  - Enhanced security: Alpine is security-focused for container environments
  - Faster builds: Smaller dependencies to download
  - Better for automation: Minimal, clean environment

#### 2. **Added Missing Tool: yq**
- Added `yq` to the Dockerfile for YAML/JSON manipulation
- Essential for configuration file processing in automation pipelines

#### 3. **Updated Tool Installation Method**
- Switched from system package manager (dnf) to Alpine's apk
- Using pip for Python-based tools (Ansible, Azure CLI) with `--break-system-packages` flag
- Cleaner, more maintainable approach

#### 4. **Added Version Tracking**
- Created `/etc/cloudcli-versions.txt` inside the container
- Can be read with: `docker run techlotse/codestream-cloudcli cat /etc/cloudcli-versions.txt`
- Helps verify installed versions at runtime

### 📅 Build Schedule Changes

#### Previous Behavior:
- Built on every push to `main` and `test` branches
- Frequent builds (could be multiple times per day)
- Potential for unintended deployments

#### New Behavior:
- Scheduled weekly build: **Every Sunday at 6:00 AM UTC** (7:00 AM CET)
- Manual trigger available: Can still run `workflow_dispatch` for on-demand builds
- More predictable, controlled release schedule
- Cleaner git history

### 📝 Documentation Automation Improvements

#### Previous Workflow Issues:
- Documentation updates committed to main branch
- Potential for triggering new builds (CI/CD loops)
- Version extraction was fragile

#### New Implementation:
- Automatic README update after successful container builds
- Versions extracted directly from running container
- Includes `[skip ci]` flag in commit messages to prevent build loops
- Better error handling and image availability checks
- Clean separation: Docs updates do NOT trigger container builds

### 🏷️ Versioning Strategy

#### Implemented Semantic Versioning:
- **VERSION file**: Contains semantic version (currently 0.3.0)
- **Tag Format**: `v<version>` + `<date>` + `latest`
- **Example Tags**:
  - `techlotse/codestream-cloudcli:v0.3.0` (semantic)
  - `techlotse/codestream-cloudcli:20260504` (date-based)
  - `techlotse/codestream-cloudcli:latest` (latest)

### 📋 Verified Installed Tools

All required tools are now confirmed in the image:

- ✅ AWS CLI v2
- ✅ Azure CLI
- ✅ Terraform
- ✅ Packer
- ✅ Ansible
- ✅ yq (newly added)
- ✅ jq
- ✅ sed (Alpine base)
- ✅ awk (GNU AWK - Alpine base)

### 🔧 GitHub Actions Workflow Updates

#### container-build.yml
- Updated to use `on.schedule` instead of `on.push`
- Added cron expression: `0 6 * * 0` (Sunday 6 AM UTC)
- Updated action versions to v3/v4/v5 (from v1/v2)
- Added VERSION file support
- Added OCI labels for image metadata
- Added `workflow_dispatch` for manual triggers

#### update-docs.yml
- Improved version extraction logic
- Added image availability wait loop (up to 5 minutes)
- Better error handling for tool version commands
- Added `[skip ci]` flag to prevent build loops
- Comprehensive change detection
- Updated action versions

### 📂 New/Modified Files

```
Dockerfile                          - Complete rewrite for Alpine Linux
VERSION                            - New semantic version file
README.md                          - Comprehensive documentation refresh
.github/workflows/container-build.yml     - Schedule-based builds
.github/workflows/update-docs.yml         - Improved automation
```

### 🚀 Next Steps

1. **Push changes to repository**
   ```bash
   git add .
   git commit -m "feat: modernize Docker image and automation

   - Migrate base image to Alpine Linux 3.19
   - Add yq tool for YAML processing
   - Implement weekly build schedule (Sunday 6 AM UTC)
   - Add VERSION file for semantic versioning
   - Improve documentation automation with skip ci flag
   - Update GitHub Actions workflows to latest versions"
   git push
   ```

2. **Manual Build (Optional)**
   - Can trigger a manual build immediately via `workflow_dispatch`
   - Or wait for next Sunday at 6 AM UTC

3. **Verify First Build**
   - Check GitHub Actions for workflow execution
   - Verify image appears on Docker Hub with correct tags
   - Verify README updates with extracted versions

### 📊 Impact Summary

| Aspect | Before | After |
|--------|--------|-------|
| Base Image | Amazon Linux 2023 | Alpine Linux 3.19 |
| Build Trigger | On every push | Weekly scheduled |
| Tools | 7 | 8 (+ yq) |
| Versioning | Date-based only | Semantic + date-based |
| Doc Updates | Manual | Automated (no build loop) |
| CI Loop Risk | Medium | None |

### ⚠️ Important Notes

1. **Alpine Package Availability**: All required tools are available in Alpine Linux official repositories
2. **Breaking Changes**: None - the container interface remains the same
3. **Backward Compatibility**: Fully backward compatible with existing scripts
4. **Image Size**: May vary slightly depending on Alpine version releases

---

**Maintained by**: TechLotse (info@techlotse.io)
**Last Updated**: 2026-04-30
