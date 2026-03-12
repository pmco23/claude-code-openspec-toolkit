# Changelog

## 2.0.0 — 2026-03-12

### Added

- Marketplace support — repo restructured as a proper marketplace following the `claude-plugins-official` layout
- Plugin now lives in `plugins/openspec-toolkit/` with marketplace.json at root
- Two-step install: `claude plugin marketplace add pmco23/claude-code-openspec-toolkit` then `claude plugin install openspec-toolkit@openspec-toolkit`

### Fixed

- Hooks moved from invalid `plugin.json` format to standard `hooks/hooks.json` with proper `type: "prompt"` and `type: "command"` entries
- All complementary plugin install commands now use correct `@claude-plugins-official` marketplace format (was using stale `github:` URLs)
- OpenSpec repo URL corrected to `Fission-AI/OpenSpec` across all docs
- Node.js version requirement updated to `20.19.0+` (was `18+`)
- Context7 install format corrected to `context7@claude-plugins-official`
- OpenSpec CLI install section moved after plugin installs in INSTALL.md

## 1.0.0 — 2026-03-12

Initial release of the OpenSpec Toolkit plugin for Claude Code.

### Commands (17)

- **AST search**: `/ast`, `/ast-find`, `/ast-lang`, `/ast-refactor` — structural code search via ast-grep
- **GitHub search**: `/gh-examples`, `/gh-fix`, `/gh-pattern`, `/gh-docs` — real-world usage and solutions via gh_grep
- **Documentation**: `/c7-docs`, `/c7-fix` — library docs via Context7
- **Codebase analysis**: `/repo-auth`, `/repo-routes`, `/repo-models`, `/repo-export`, `/repo-export-slim` — architecture mapping and export

### Skills (5)

- `pre-propose` — codebase mapping before `/opsx:propose`
- `post-apply` — combined quality gate (spec compliance + security + code quality)
- `spec-review` — lighter review (spec compliance + code quality, no security scan)
- `debug-investigate` — structured debugging workflow
- `test-scaffold` — generate test stubs from tasks.md for TDD

### Hooks (3)

- `pre-apply-guard` — warns if `/opsx:apply` runs without config or with vague criteria
- `pre-archive-guard` — warns if archiving without a quality review
- `session-context` — auto-detects active OpenSpec change on session start

### Agents (1)

- `review-agent` — read-only code review (Grep, Glob, ast-grep only)

### Other

- MIT license
- Install guide with prerequisite checks, complementary plugin recommendations, and LSP setup
- 13 end-to-end workflow examples in `workflows.md`
- Per-project toolkit settings via `openspec/config.yaml` `toolkit:` section
