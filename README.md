# OpenSpec Toolkit — Claude Code Plugin

Opinionated Claude Code plugin for spec-driven development with [OpenSpec](https://github.com/openspec-dev/openspec). Provides AST search, GitHub code search, documentation lookup, codebase analysis, and spec review.

## Prerequisites

- **Node.js** 18+ (for repomix and context7 via npx)
- **Docker** (for ast-grep MCP server)
- **context7 plugin** installed separately (`claude plugin install @anthropic/context7` or equivalent)

## Installation

```bash
claude plugin install /path/to/claude-code-openspec-toolkit
```

Or from a GitHub repo:

```bash
claude plugin install github:pemcoliveira/claude-code-openspec-toolkit
```

## MCP Servers

| Server | Purpose | Transport |
|--------|---------|-----------|
| `gh_grep` | Search public GitHub code | HTTP remote |
| `ast-grep` | Structural AST search | Docker stdio |
| `repomix` | Codebase export to XML | npx stdio |

Context7 is expected as a separate plugin and is not bundled here.

## Commands (17)

### AST Search (ast-grep)

| Command | Description |
|---------|-------------|
| `/ast <pattern>` | Structural AST search with ast-grep pattern |
| `/ast-find <symbol>` | Find all definitions, calls, and imports of a symbol |
| `/ast-lang <lang> <pattern>` | Language-scoped AST search |
| `/ast-refactor <pattern>` | Find all sites matching a refactoring target |

### GitHub Code Search (gh_grep)

| Command | Description |
|---------|-------------|
| `/gh-examples <query>` | Find real-world usage examples on GitHub |
| `/gh-pattern <pattern>` | Find how a pattern is used across GitHub projects |
| `/gh-fix <error>` | Find real-world solutions to an error |
| `/gh-docs <topic>` | Official docs + real-world GitHub usage combined |

### Documentation (Context7)

| Command | Description |
|---------|-------------|
| `/c7-docs <library>` | Look up docs for a library |
| `/c7-fix <error>` | Find docs to fix the current error |

### Codebase Analysis (Grep + ast-grep)

| Command | Description |
|---------|-------------|
| `/repo-auth` | Map all authentication and authorization code |
| `/repo-routes` | Map all API routes and HTTP endpoints |
| `/repo-models` | Map all database models and schemas |
| `/repo-errors` | Audit all error handling patterns |
| `/repo-review` | Full code review: text scan + structural audit |

### Export (Repomix CLI)

| Command | Description |
|---------|-------------|
| `/repo-export [path]` | Export full repomix XML snapshot to disk |
| `/repo-export-slim [path]` | Export compressed repomix XML snapshot to disk |

## Skills

### spec-review

Post-implementation review that verifies OpenSpec `tasks.md` compliance and audits code quality.

```
Load the spec-review skill and review the add-dark-mode change
```

## Workflow

See `CLAUDE.md` for the full workflow rules that get loaded into every session. Key flow:

1. Map the codebase: `/repo-auth`, `/repo-routes`, `/repo-models`
2. Propose changes with OpenSpec: `/opsx:propose`
3. Implement: `/opsx:apply`
4. Review: load the `spec-review` skill
5. Archive: `/opsx:archive`

## License

MIT
