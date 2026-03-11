# OpenSpec Toolkit — Workflow Rules

## Researching libraries

- For official API references and how-to questions, use the context7 MCP tools (`resolve-library-id` + `query-docs`) or run `/c7-docs`
- For real-world usage patterns and debugging errors, use the gh_grep MCP tool or run `/gh-examples`, `/gh-fix`
- When both are relevant (validating docs against real usage), run `/gh-docs` which combines both

## Exploring the codebase

- Use Grep and Glob for text search: file structure, topic searches, config values, comments
- Use ast-grep (via `/ast`, `/ast-find`) for precise structural queries: function definitions, call sites, imports, anti-patterns
- For unfamiliar codebases, run `/repo-auth`, `/repo-routes`, `/repo-models` to map what exists before writing code

## OpenSpec workflow

Before running `/opsx:propose` on an existing codebase:
1. Run `/repo-auth`, `/repo-routes`, `/repo-models` to map what exists
2. Save key findings to memory
3. Seed `openspec/config.yaml` with architecture conventions before generating artifacts

For bug fixes, skip the full spec pipeline: use `/opsx:explore` to diagnose first,
then `/opsx:propose fix-<name>` with a minimal tasks.md (1-3 tasks).

## After implementing

After `/opsx:apply`, load the spec-review skill and run it before archiving:
"Load the spec-review skill and review the `<change-name>` change."

## Multi-step tasks

For features, refactoring, or debugging with more than 2 steps, use plan mode to plan before acting.
