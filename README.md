# OpenSpec Toolkit — Claude Code Plugin

Opinionated Claude Code plugin for spec-driven development with [OpenSpec](https://github.com/Fission-AI/OpenSpec). Provides AST search, GitHub code search, documentation lookup, codebase analysis, and spec review.

## Prerequisites

- **Node.js** 20.19.0+ (for repomix and context7 via npx)
- **Docker** (for ast-grep MCP server)
- **context7 plugin** installed separately (`claude plugin install context7@claude-plugins-official` or equivalent)

## Installation

### From GitHub (marketplace)

```bash
claude plugin install openspec-toolkit@pmco23/claude-code-openspec-toolkit
```

### From a local clone

```bash
git clone https://github.com/pmco23/claude-code-openspec-toolkit.git
claude plugin install /path/to/claude-code-openspec-toolkit
```

## MCP Servers

| Server | Purpose | Transport |
|--------|---------|-----------|
| `gh_grep` | Search public GitHub code | HTTP remote |
| `ast-grep` | Structural AST search | Docker stdio |
| `repomix` | Codebase export to XML | npx stdio |

Context7 is expected as a separate plugin and is not bundled here.

## Hooks (3)

| Hook | Event | Purpose |
|------|-------|---------|
| `pre-apply-guard` | PreToolUse | Warns if `/opsx:apply` runs without `config.yaml` or with vague acceptance criteria |
| `pre-archive-guard` | PreToolUse | Warns if archiving without running a quality review first |
| `session-context` | SessionStart | Auto-detects active OpenSpec change and injects context into the session |

## Agents (1)

| Agent | Purpose |
|-------|---------|
| `review-agent` | Read-only code review (Grep, Glob, ast-grep only — cannot modify files) |

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

## Skills (5)

| Skill | Description | When to use |
|-------|-------------|-------------|
| `pre-propose` | Map auth, routes, models and suggest config.yaml seed | Before first `/opsx:propose` on a new project |
| `post-apply` | Combined quality gate: spec compliance + security + code quality → go/no-go | After `/opsx:apply`, before archiving |
| `debug-investigate` | Structured debugging: docs + GitHub + AST + error audit → diagnosis | When debugging a specific error or symptom |
| `spec-review` | Two-pass review: tasks.md compliance + code quality audit | Lighter alternative to `post-apply` (no security scan) |
| `test-scaffold` | Extract acceptance criteria from tasks.md, scaffold test files | Before implementing tasks during `/opsx:apply` for TDD |

### Usage

```
Load the pre-propose skill and map this codebase for OpenSpec
Load the post-apply skill and review the add-dark-mode change
Load the debug-investigate skill and debug this error: Cannot read properties of undefined
Load the spec-review skill and review the add-dark-mode change
Load the test-scaffold skill and scaffold tests for the add-dark-mode change
```

## Workflow

See `CLAUDE.md` for the full workflow rules that get loaded into every session. See `workflows.md` for 13 end-to-end workflow recipes. Key flow:

1. Map the codebase: load the `pre-propose` skill (or run `/repo-auth`, `/repo-routes`, `/repo-models` manually)
2. Propose changes with OpenSpec: `/opsx:propose`
3. Scaffold tests: load the `test-scaffold` skill to generate test stubs from tasks.md
4. Implement: `/opsx:apply` (with TDD — make scaffolded tests pass)
5. Review: load the `post-apply` skill for go/no-go verdict
6. Archive: `/opsx:archive`

For debugging: load the `debug-investigate` skill with your error message.

## Installation

See [INSTALL.md](./INSTALL.md) for the full installation guide, including prerequisites, complementary plugins, and verification steps.

## License

MIT
