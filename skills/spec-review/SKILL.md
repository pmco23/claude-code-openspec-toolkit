---
name: spec-review
description: Two-pass post-implementation review: verify OpenSpec tasks.md compliance then audit code quality for debug leftovers, secrets, and empty catches. Use after completing an OpenSpec change and before archiving.
---

## What I do

After implementing an OpenSpec change, perform a two-pass review before archiving.

### Pass 1 — Spec compliance

1. Identify the change to review:
   - If a change name was provided, read `openspec/changes/<name>/tasks.md`
   - Otherwise, find the most recently modified non-archived change folder under `openspec/changes/`
2. Read `tasks.md` with the Read tool
3. For each task in `tasks.md`, use the ast-grep MCP tool to verify it is implemented in the codebase
4. Report each task as: **done** / **incomplete** / **missing**

### Pass 2 — Code quality

1. Use Grep to scan the codebase for:
   - `TODO|FIXME|HACK` — unfinished work
   - `console\.log|debugger` — debug leftovers
   - `password|secret|api_key|apikey|private_key` — potential hardcoded secrets
2. Use the ast-grep MCP tool to find:
   - Empty catch blocks: `try { $$$ } catch($E) {}`
   - Missing return type annotations on exported functions

## Output format

Produce a single prioritized report:

1. **Spec gaps** (tasks incomplete or missing) — blocks archiving
2. **Critical** code issues (secrets, empty catches)
3. **High** (debug code, missing types)
4. **Medium** (TODO/FIXME markers)

Include file and line references for every finding.

## When to use me

Load this skill after implementing an OpenSpec change and before archiving. Run it on any change to catch spec drift and code quality issues.

```
Load the spec-review skill and review the add-dark-mode change
```

Or for the most recent change:

```
Load the spec-review skill and review the current change
```
