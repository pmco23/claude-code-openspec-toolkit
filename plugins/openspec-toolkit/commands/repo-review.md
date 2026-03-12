---
description: "Full code review: text scan + ast-grep structural audit"
allowed-tools: ["Grep", "Glob", "Read", "mcp__ast-grep__*"]
---

Perform a thorough code review in two passes:

**Pass 1 — Text patterns** (using Grep):
1. `TODO|FIXME|HACK|XXX` — tech debt markers
2. `console\.log|debugger|print\(` — debug leftovers
3. `password|secret|api_key|apikey|private_key` — potential hardcoded secrets

**Pass 2 — Structural patterns** (using ast-grep MCP):
1. Empty catch blocks
2. Functions with many statements (overly long)
3. Duplicate code shapes
4. Missing return type annotations on exported functions

Produce a single prioritized report:
- **Critical** (secrets, empty catches)
- **High** (debug code, missing types)
- **Medium** (tech debt, long functions)

Include file and line references for every finding.
