---
description: Map all authentication and authorization code
allowed-tools: ["Grep", "Glob", "Read", "mcp__ast-grep__*"]
---

Map all authentication and authorization code in the current project.

**Step 1 — Text search**: Use Grep to search across the codebase for patterns related to auth:
- Pattern: `auth|login|logout|token|jwt|session|password|permission|role`
- Identify which files contain authentication and authorization logic. List those files.

**Step 2 — Structural search**: Use the ast-grep MCP tool to search those files for:
- Function definitions with `auth` or `login` in their name
- Calls to auth-related functions
- Import statements for auth libraries

Group by file and describe the role each plays in the auth flow.
