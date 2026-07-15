# GitHub Action Release Preparation Report

This report outlines the git commands and deployment steps required to publish the Action to the GitHub Marketplace.

---

## 1. Publishing Steps & Git Commands

To release version `v1.0.0` (and `v1` major version tag) to the GitHub Marketplace, execute the following commands in the `taintflow-action` folder:

```bash
# 1. Initialize local repository and set up main
cd "d:\V2 Backup\taintflow-action"
git init
git checkout -b main

# 2. Stage and commit all files
git add .
git commit -m "feat: initial release of TaintFlow SAST action v1.0.0"

# 3. Add remote pointer to the action repository
git remote add origin https://github.com/h3lium4u/taintflow-action.git

# 4. Push code to remote main branch
git push -u origin main

# 5. Create local tags for version tracking
git tag -a v1.0.0 -m "Release version 1.0.0"
git tag -a v1 -m "Release major version 1"

# 6. Push tags to trigger GitHub Release creation and Marketplace indexing
git push origin --tags
```

---

## 2. GitHub Marketplace Publication Lifecycle

After pushing the tags:
1. Navigate to `https://github.com/h3lium4u/taintflow-action`.
2. Click **Draft a new release** on the releases page.
3. Select the tag `v1.0.0`.
4. Check the box **Publish this Action to the GitHub Marketplace**.
5. Accept the developer agreement, write a title (e.g. `v1.0.0`), paste the notes from `MARKETPLACE_RELEASE_NOTES.md`, and click **Publish release**.
