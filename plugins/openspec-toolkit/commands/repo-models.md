---
description: Map all database models and schema definitions
allowed-tools: ["Grep", "Glob", "Read", "mcp__ast-grep__*"]
---

Map all database models and schema definitions in the current project.

**Step 1 — Text search**: Use Grep to search across the codebase for model/schema patterns:
- Pattern: `model|schema|entity|defineModel|createSchema|mongoose|sequelize|prisma|typeorm`
- Identify which files define data models or schemas. List those files.

**Step 2 — Structural search**: Use the ast-grep MCP tool to extract the structural definitions from those files: class names, exported objects, field names and types.

Summarize the data model layout.
