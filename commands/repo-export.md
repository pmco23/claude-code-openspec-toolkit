---
description: Export a full repomix XML snapshot to disk
argument-hint: "[output path]"
allowed-tools: ["mcp__repomix__*"]
---

Export the current working directory using the repomix MCP tool `pack_codebase`.

Call `pack_codebase` with:
- `directory`: the current working directory (absolute path)
- `compress`: false
- `style`: "xml"

Report the output file path and the key metrics (total files, total tokens) from the response.
