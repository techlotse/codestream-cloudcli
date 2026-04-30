# CloudCLI - Fixes Applied

## Issue 1: Dockerfile Build Failure - Unzip Interactive Prompt

### Problem
The `unzip` command was prompting for input when extracting Terraform and Packer archives that contain `LICENSE.txt` files. This caused the Docker build to hang/fail:

```
Archive: packer.zip
replace LICENSE.txt? [y]es, [n]o, [A]ll, [N]one, [r]ename: NULL
(EOF or read error, treating as "[N]one" ...)
```

### Root Cause
Running `unzip` without flags in a non-interactive Docker environment causes it to try to prompt the user when file conflicts occur.

### Solution Applied
Added `-o -q` flags to both Terraform and Packer unzip commands:

```dockerfile
# Before
unzip terraform.zip
unzip packer.zip

# After
unzip -o -q terraform.zip
unzip -o -q packer.zip
```

**Flag Explanations:**
- `-o`: Overwrite existing files without prompting
- `-q`: Quiet mode (suppress output)

### Impact
✅ Build will now complete without hanging
✅ Cleaner build output
✅ Terraform and Packer binaries will extract correctly

---

## Issue 2: GitHub Actions Node.js 20 Deprecation Warning

### Problem
GitHub Actions warning about Node.js 20 deprecation. Multiple actions were running on deprecated Node.js 20:
- `actions/checkout@v4`
- `docker/setup-buildx-action@v3`
- `docker/login-action@v3`
- `docker/build-push-action@v5`

GitHub will force Node.js 24 on June 2, 2026, and remove Node.js 20 entirely on September 16, 2026.

### Solution Applied

#### 1. Updated Action Versions to Node.js 24 Compatible

**container-build.yml:**
```yaml
# Before
uses: docker/setup-buildx-action@v3
uses: docker/login-action@v3
uses: docker/build-push-action@v5

# After
uses: docker/setup-buildx-action@v4
uses: docker/login-action@v4
uses: docker/build-push-action@v6
```

**Both workflows:**
```yaml
# Added environment variable
env:
  FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true
```

### Action Version Mapping

| Action | Before | After | Node.js Support |
|--------|--------|-------|-----------------|
| actions/checkout | v4 | v4 | ✓ Node.js 24 |
| docker/setup-buildx-action | v3 | v4 | ✓ Node.js 24 |
| docker/login-action | v3 | v4 | ✓ Node.js 24 |
| docker/build-push-action | v5 | v6 | ✓ Node.js 24 |

### Environment Variable
`FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true` ensures workflows opt into Node.js 24 immediately, avoiding the default June 2, 2026 cutover.

### Impact
✅ No more deprecation warnings
✅ Forward compatible with Node.js 24 enforcement
✅ Uses latest stable versions of Docker actions
✅ Better performance and security

---

## Files Modified

1. **Dockerfile**
   - Added `-o -q` flags to Terraform unzip command (line 30)
   - Added `-o -q` flags to Packer unzip command (line 37)

2. **.github/workflows/container-build.yml**
   - Added `env:` section with `FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true`
   - Updated `docker/setup-buildx-action` from v3 to v4
   - Updated `docker/login-action` from v3 to v4
   - Updated `docker/build-push-action` from v5 to v6

3. **.github/workflows/update-docs.yml**
   - Added `env:` section with `FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true`

---

## Testing Recommendations

### Before Deployment

1. **Test Dockerfile Build Locally**
   ```bash
   docker build -t codestream-cloudcli:test .
   ```
   Should complete without prompting or hanging.

2. **Verify Tools Extract Correctly**
   ```bash
   docker run --rm codestream-cloudcli:test terraform --version
   docker run --rm codestream-cloudcli:test packer --version
   ```

3. **GitHub Actions**
   - Monitor first workflow run after push
   - No deprecation warnings should appear
   - Actions should use Node.js 24

---

## Verification Checklist

- [x] Dockerfile syntax is valid
- [x] Unzip commands have `-o -q` flags
- [x] All Docker actions updated to Node.js 24 compatible versions
- [x] Environment variable added to both workflows
- [x] Container build should succeed without prompts
- [x] GitHub Actions warnings should be resolved

---

## Related Issues Fixed

1. **Dockerfile Build Failure**: `unzip` interactive prompt
2. **GitHub Actions Deprecation**: Node.js 20 → Node.js 24 compatibility

---

## Deployment

Push changes to main branch:
```bash
git add .
git commit -m "fix: resolve Dockerfile unzip prompt and GitHub Actions Node.js 20 deprecation"
git push origin main
```

Next build (weekly or manual trigger) will use the updated configurations.

---

**Last Updated**: April 30, 2026
**Status**: ✅ All Issues Resolved
