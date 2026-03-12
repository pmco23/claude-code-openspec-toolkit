# OpenSpec Toolkit — Installation Guide

## Prerequisites

| Requirement | Version | Why |
|-------------|---------|-----|
| **Node.js** | 20.19.0+ | Required by OpenSpec CLI; also runs repomix and context7 via npx |
| **Docker** | Any recent | Runs the ast-grep MCP server |
| **GitHub CLI** (`gh`) | 2.0+ | Used by gh_grep for authenticated searches |

Verify prerequisites:

```bash
node --version    # v20.19.0+
docker --version  # any
gh --version      # 2.0+
gh auth status    # must be authenticated
```

## Install the OpenSpec Toolkit Plugin

From GitHub (marketplace):

```bash
claude plugin install openspec-toolkit@pmco23/claude-code-openspec-toolkit
```

Or from a local clone:

```bash
git clone https://github.com/pmco23/claude-code-openspec-toolkit.git
claude plugin install ./claude-code-openspec-toolkit
```

After installation, verify with:

```bash
claude /help
```

You should see `/ast`, `/repo-auth`, `/c7-docs`, `/gh-fix`, and other toolkit commands listed.

## Install OpenSpec CLI (Required)

The toolkit complements the [OpenSpec](https://github.com/Fission-AI/OpenSpec) CLI. Install it globally:

```bash
npm install -g @fission-ai/openspec@latest
```

Verify the installation and initialize in your project:

```bash
openspec --version
cd your-project
openspec init
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

#### LSP Code Intelligence

Claude Code LSP plugins give Claude real-time diagnostics, go-to-definition, and find-references — enhancing code review, debugging, and implementation. After each edit, the language server reports errors and warnings automatically, so Claude catches type errors, missing imports, and syntax issues without running a compiler.

**Two-step install**: install the language server binary, then install the plugin.

| Language | Plugin | Binary required | Install binary |
|----------|--------|-----------------|----------------|
| TypeScript | `typescript-lsp` | `typescript-language-server` | `npm install -g typescript-language-server typescript` |
| Python | `pyright-lsp` | `pyright-langserver` | `pip install pyright` or `npm install -g pyright` |
| Go | `gopls-lsp` | `gopls` | `go install golang.org/x/tools/gopls@latest` |
| Rust | `rust-analyzer-lsp` | `rust-analyzer` | [rust-analyzer install guide](https://rust-analyzer.github.io/manual.html#installation) |
| Java | `jdtls-lsp` | `jdtls` | [Eclipse JDT.LS](https://github.com/eclipse-jdtls/eclipse.jdt.ls) |
| PHP | `php-lsp` | `intelephense` | `npm install -g intelephense` |
| C/C++ | `clangd-lsp` | `clangd` | Install via your system package manager |
| C# | `csharp-lsp` | `csharp-ls` | `dotnet tool install -g csharp-ls` |
| Kotlin | `kotlin-lsp` | `kotlin-language-server` | [kotlin-language-server releases](https://github.com/fwcd/kotlin-language-server) |
| Lua | `lua-lsp` | `lua-language-server` | [lua-language-server releases](https://github.com/LuaLS/lua-language-server) |
| Swift | `swift-lsp` | `sourcekit-lsp` | Included with Swift toolchain |

Install plugins from the official marketplace:

```bash
claude plugin install typescript-lsp@claude-plugins-official
claude plugin install pyright-lsp@claude-plugins-official
# repeat for each language you use
```

**OpenSpec phase**: All phases — diagnostics fire automatically during `/opsx:apply` and review. Code navigation enhances `debug-investigate` and `pre-propose` codebase mapping.

> **Tip**: Use `--scope project` to share LSP plugin configuration with your team.

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
