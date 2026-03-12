---
description: Audit all error handling patterns in the codebase
allowed-tools: ["Grep", "Glob", "Read", "mcp__ast-grep__*"]
---

Audit error handling across the codebase using the ast-grep MCP tool.

Search for:
1. **Empty catch blocks** — `try { $$$ } catch($E) {}`
2. **Catch blocks that only log** — `catch($E) { console.$METHOD($$$) }` without rethrowing
3. **Unhandled promise rejections** — `.catch($F)` where the handler is trivial
4. **Throw statements** — map what errors are raised and where

Group findings by severity:
- **Silent failures** (empty catches) first
- **Logged-only** (no rethrow) second
- **Properly handled** last

Report file and line for each finding.
