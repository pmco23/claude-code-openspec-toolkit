# OpenSpec Toolkit — Installation Guide

## Prerequisites

| Requirement | Version | Why |
|-------------|---------|-----|
| **Node.js** | 18+ | Runs repomix and context7 via npx |
| **Docker** | Any recent | Runs the ast-grep MCP server |
| **GitHub CLI** (`gh`) | 2.0+ | Used by gh_grep for authenticated searches |

Verify prerequisites:

```bash
node --version    # v18+
docker --version  # any
gh --version      # 2.0+
gh auth status    # must be authenticated
```

## Install the OpenSpec Toolkit Plugin

From a local clone:

```bash
git clone https://github.com/pemcoliveira/claude-code-openspec-toolkit.git
claude plugin install ./claude-code-openspec-toolkit
```

Or directly from GitHub:

```bash
claude plugin install github:pemcoliveira/claude-code-openspec-toolkit
```

After installation, verify with:

```bash
claude /help
```

You should see `/ast`, `/repo-auth`, `/c7-docs`, `/gh-fix`, and other toolkit commands listed.

## Install OpenSpec (Required)

The toolkit complements the [OpenSpec](https://github.com/openspec-dev/openspec) plugin. Install it if you haven't:

```bash
claude plugin install github:openspec-dev/openspec
```

## Recommended Complementary Plugins

These plugins integrate well with the OpenSpec workflow. They are optional but recommended.

### Tier 1 — High Synergy

#### pr-review-toolkit

6 specialized review agents for granular post-implementation review. Complements the `spec-review` and `post-apply` skills.

```bash
claude plugin install github:nichochar/pr-review-toolkit
```

**What it adds**: `/pr-review`, silent-failure-hunter agent, pr-test-analyzer agent, error-handling reviewer, type reviewer, code-quality reviewer, simplification reviewer.

**OpenSpec phase**: Review — run after `post-apply` for deeper code analysis.

#### security-guidance

PreToolUse hook that passively detects 9 security anti-patterns during implementation.

```bash
claude plugin install github:anthropics/claude-code-security-guidance
```

**What it adds**: Automatic warnings during `/opsx:apply` when code contains command injection, XSS, eval, pickle, os.system, and other security risks.

**OpenSpec phase**: Implement — fires automatically, no commands to run.

#### code-simplifier

Post-review cleanup agent that simplifies code without changing behavior.

```bash
claude plugin install github:anthropics/claude-code-code-simplifier
```

**What it adds**: `/simplify` command for cleaning up code after review.

**OpenSpec phase**: Review/Archive — run after `post-apply` passes as a final polish step.

### Tier 2 — Useful Additions

#### commit-commands

Commit workflow shortcuts.

```bash
claude plugin install github:anthropics/claude-code-commit-commands
```

**What it adds**: `/commit`, `/commit-push-pr`, `/clean_gone`

#### context7

Library documentation lookup (required by `/c7-docs` and `/c7-fix`).

```bash
claude plugin install github:anthropics/context7
```

**What it adds**: context7 MCP server for resolving library docs.

## Verify Installation

After installing all plugins:

```bash
# Reload plugins
claude /reload-plugins

# Check installed plugins
claude /plugins
```

Verify each toolkit command works:

```
/ast console.log($ARG)       # AST search
/c7-docs express              # Library docs
/gh-examples prisma insert    # GitHub code search
/repo-auth                    # Codebase auth mapping
```

## Recommended Workflow After Installation

1. **Map**: Load the `pre-propose` skill on a new project
2. **Propose**: `/opsx:propose <change>`
3. **Implement**: `/opsx:apply` (security-guidance fires automatically)
4. **Review**: Load the `post-apply` skill for go/no-go verdict
5. **Polish**: `/simplify` (if code-simplifier is installed)
6. **Archive**: `/opsx:archive`

For debugging: load the `debug-investigate` skill with your error message.
