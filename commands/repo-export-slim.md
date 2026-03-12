---
description: Export a compressed repomix XML snapshot to disk
argument-hint: "[output path]"
allowed-tools: ["mcp__repomix__*"]
---

Export the current working directory using the repomix MCP tool `pack_codebase` in compressed mode.

Call `pack_codebase` with:
- `directory`: the current working directory (absolute path)
- `compress`: true
- `style`: "xml"

Report the output file path and the key metrics (total files, total tokens) from the response, including any compression savings.
