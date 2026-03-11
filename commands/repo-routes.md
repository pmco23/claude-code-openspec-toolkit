---
description: Map all API routes and HTTP endpoint definitions
allowed-tools: ["Grep", "Glob", "Read", "mcp__ast-grep__*"]
---

Map all API routes and HTTP endpoint definitions in the current project.

**Step 1 — Text search**: Use Grep to search across the codebase for route-related patterns:
- Pattern: `router|route|@Get|@Post|@Put|@Delete|@Patch|app\.get|app\.post|app\.put|app\.delete`
- Identify which files define routes or endpoints. List those files.

**Step 2 — Structural search**: Use the ast-grep MCP tool to extract the precise route definitions from those files: method, path, and handler name.

Produce a clean summary table of all endpoints found.
