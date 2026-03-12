---
name: post-apply
description: This skill runs a combined quality gate after implementing an OpenSpec change — spec-review compliance check, security scan, and code quality audit — then produces a single go/no-go report. This skill should be used after /opsx:apply and before archiving, when asked to "review and prepare to archive" a change, or as a final quality gate before opening a PR. For a lighter review without the security scan, use the spec-review skill instead.
---

## What I do

After implementing an OpenSpec change, run a combined quality gate that checks spec compliance, security, and code quality in one pass. Produces a single go/no-go verdict.

**Note:** This is the full quality gate. For a lighter review (spec compliance + code quality only, no security scan), use the `spec-review` skill instead.

### Step 0 — Load project settings

Check if `openspec/config.yaml` exists and has a `toolkit:` section. If it does, read the toolkit settings and apply overrides:
- If `security-scan: false`, skip Pass 2 entirely
- If `custom-secret-patterns` has entries, add them to the security scan patterns
- If `skip-quality-patterns` has entries, exclude matching files from the code quality scan

If the file does not exist or has no `toolkit:` section, use defaults (all passes enabled, no custom patterns).

### Pass 1 — Spec compliance (tasks.md verification)

1. Identify the change to review:
   - If a change name was provided, read `openspec/changes/<name>/tasks.md`
   - Otherwise, find the most recently modified non-archived change folder under `openspec/changes/`
2. Read `tasks.md` with the Read tool
3. For each task in `tasks.md`, use the ast-grep MCP tool and Grep to verify it is implemented in the codebase
4. Report each task as: **done** / **incomplete** / **missing**

### Pass 2 — Security scan

Use Grep to scan changed/new files for:
- Hardcoded secrets: `password\s*=\s*['"]`, `api_key\s*=\s*['"]`, `secret\s*=\s*['"]`, `private_key`
- Dangerous patterns: `eval(`, `exec(`, `innerHTML\s*=`, `dangerouslySetInnerHTML`
- SQL injection vectors: string concatenation in SQL queries (e.g., `query.*\+.*req\.`)
- Command injection: `child_process.exec(` with string concatenation, `os.system(` with f-strings

Use the ast-grep MCP tool to find:
- `eval($EXPR)` calls
- Unparameterized SQL: template literals or concatenation inside query/execute calls

### Pass 3 — Code quality audit

Use Grep to scan for:
- `TODO|FIXME|HACK` — unfinished work
- `console\.log|debugger|print\(` — debug leftovers
- `\.only\(` — focused test selectors left in

Use the ast-grep MCP tool to find:
- Empty catch blocks: `try { $$$ } catch($E) {}`
- Functions longer than 50 lines (heuristic — flag for review, not a blocker)

### Output — Go/No-Go Report

Produce a single report with severity levels:

```
## Post-Apply Quality Report: <change-name>

### Verdict: GO / NO-GO

### Spec Compliance
- [x] Task 1: description — done
- [ ] Task 2: description — incomplete (detail)

### Security (blocks GO)
- CRITICAL: [finding with file:line]

### Code Quality
- HIGH: [debug leftovers with file:line]
- MEDIUM: [TODO markers with file:line]
- LOW: [style issues]

### Recommendation
[If GO]: Ready to archive. Run `/opsx:archive` to close this change.
[If NO-GO]: Fix the items above, then re-run this review.
```

Severity mapping:
- **Spec gaps** → NO-GO (blocks archiving)
- **Security findings** → NO-GO
- **Debug leftovers** → HIGH (should fix, but doesn't block)
- **TODO/FIXME** → MEDIUM (acceptable if intentional)
- **Style issues** → LOW (informational)

Only spec gaps and security findings block the GO verdict.

## When to use me

- After `/opsx:apply` and before `/opsx:archive`
- When asked to "review and prepare to archive" a change
- As a final quality gate before opening a PR

```
Load the post-apply skill and review the add-dark-mode change
```

Or for the most recent change:

```
Load the post-apply skill and prepare to archive
```
