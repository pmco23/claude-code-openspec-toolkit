---
description: Language-scoped AST search
argument-hint: "<lang> <pattern>"
allowed-tools: ["mcp__ast-grep__*"]
---

Use the ast-grep MCP tool to search the current working directory.

Input format is `<lang> <pattern>`, e.g. `typescript async function $FUNC($$$ARGS)`.

Parse the first word of `$ARGUMENTS` as the language and the rest as the AST pattern. Report all matches grouped by file.
