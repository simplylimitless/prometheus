---
name: pr-description-standard
description: PR descriptions must be thorough — explain what changed, why, and impact; apply across all projects
metadata:
  type: user
  tags: [PR, workflow, code-review]
---

PR descriptions must be detailed and explanatory. For every PR, include:
- **What changed**: enumerate each file touched and the specific modification (not just "updated README" — say "added docker-compose quick-start section, moved config details from CLAUDE.md").
- **Why**: the rationale behind the change (e.g., "docker-compose is the recommended local dev path now; removing COPY avoids stale in-image config").
- **Impact**: what this means for users or downstream workflows (e.g., "existing docker run commands still work unchanged; new users get a one-command setup").
- No summary-only PR bodies. This is a global rule across all projects.
