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
1. Load the `pre-propose` skill to map auth, routes, and models in one pass
2. Review the summary and suggested `config.yaml` seed
3. Save key findings to memory
4. Seed `openspec/config.yaml` with architecture conventions before generating artifacts

For bug fixes, skip the full spec pipeline: use `/opsx:explore` to diagnose first,
then `/opsx:propose fix-<name>` with a minimal tasks.md (1-3 tasks).

## After implementing

After `/opsx:apply`, load the `post-apply` skill for a combined quality gate:
"Load the post-apply skill and review the `<change-name>` change."

This runs spec compliance + security scan + code quality audit and produces a go/no-go verdict.
If GO, proceed to `/opsx:archive`. If NO-GO, fix the flagged items first.

For a lighter review (spec compliance + code quality only, no security scan), use `spec-review` directly:
"Load the spec-review skill and review the `<change-name>` change."

## Debugging

For structured debugging, load the `debug-investigate` skill:
"Load the debug-investigate skill and debug this error: `<error message>`"

This chains documentation lookup, GitHub solutions, AST search, and error handling audit into a single diagnosis.

## TDD discipline

Before implementing, load the `test-scaffold` skill to generate test stubs from tasks.md:
"Load the test-scaffold skill and scaffold tests for the `<change-name>` change."

Then follow red-green-refactor when tasks.md has testable acceptance criteria:
1. **Red** — Run the scaffolded tests; they should all fail
2. **Green** — Implement the minimum code to make each test pass
3. **Refactor** — Clean up only after green, without changing behavior

This applies especially to tasks with clear input/output expectations. Skip TDD for pure config changes, migrations, or UI-only tasks where automated testing adds no value.

TDD enforcement can be configured per-project via the `toolkit:` section in `openspec/config.yaml` (included in the `pre-propose` config seed).

## Per-project settings

Toolkit settings live in `openspec/config.yaml` under the `toolkit:` key, alongside OpenSpec's own `schema`, `context`, and `rules`. The `pre-propose` skill includes these settings in its config seed suggestion. Options:
- `security-scan`: enable/disable security pass in `post-apply`
- `tdd-enforce`: `auto` | `always` | `never`
- `custom-secret-patterns`: additional regex patterns for secret detection
- `skip-quality-patterns`: file patterns to exclude from quality scans

## Multi-step tasks

For features, refactoring, or debugging with more than 2 steps, use plan mode to plan before acting.
