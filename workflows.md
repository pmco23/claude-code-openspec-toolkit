# Workflows

End-to-end workflows combining OpenSpec (`/opsx:*`) with the toolkit's commands (`/repo-*`, `/ast-*`, `/gh-*`, `/c7-*`) and skills.

For command details, see [README.md](./README.md). For OpenSpec commands, see [OpenSpec docs](https://github.com/Fission-AI/OpenSpec/blob/main/docs/commands.md).

---

## 1. Onboarding to an Unfamiliar Codebase

You've just cloned a repo you've never seen before.

```
Load the pre-propose skill and map this codebase for OpenSpec
```
Maps auth, routes, and models in one pass. Produces a structured summary and suggests `config.yaml` seed content. Saves key findings to memory.

Alternatively, run the individual commands manually:

```
/repo-auth
/repo-routes
/repo-models
```

```
/repo-errors
```
Audit error handling — find swallowed errors, empty catches, and debug leftovers before you start.

```
/repo-export
```
Optional: create a reusable XML snapshot for handoff or another tool. Use `/repo-export-slim` for a smaller compressed version.

---

## 2. New Feature — Fast Path

Clear requirements, straightforward feature. Full spec pipeline in sequence.

```
/repo-auth
/repo-routes
/repo-models
```
Map what exists before writing a proposal.

```
/opsx:propose add user notification preferences
```
Creates `proposal.md`, `specs/`, `design.md`, and `tasks.md` in one pass. Review and edit artifacts if needed.

```
/c7-docs drizzle-orm
/gh-docs drizzle-orm insert and update
```
Research the implementation approach — `/gh-docs` combines official docs with real-world GitHub usage.

```
Load the test-scaffold skill and scaffold tests for the add-user-notification-preferences change
```
Scaffold test files with assertion placeholders from tasks.md acceptance criteria — the red phase of TDD.

```
/opsx:apply
```
Implement in a **clean context window**. Works through `tasks.md` task by task, making scaffolded tests pass.

```
Load the post-apply skill and review the add-user-notification-preferences change
```
Combined quality gate: spec compliance + security scan + code quality audit. Produces a go/no-go verdict.

```
/opsx:archive
```
Syncs delta specs and moves the change to `openspec/changes/archive/`.

---

## 3. New Feature — Careful Path

Requirements are fuzzy or the feature is complex. Explore before committing.

```
/opsx:explore how should we structure the notification preferences?
```
Investigate the codebase, compare approaches, clarify requirements. No artifacts created.

```
/repo-auth
/repo-models
```
Map existing patterns to inform the design.

Once direction is clear:

```
/opsx:new add-notification-preferences
/opsx:continue
```
Creates the change folder, then the first artifact (proposal). Review and edit.

```
/opsx:continue
/opsx:continue
/opsx:continue
```
Step through each artifact: specs → design → tasks. Review between each step.

```
Load the test-scaffold skill and scaffold tests for the add-notification-preferences change
```
Scaffold test files before implementing — sets up the red phase for TDD.

```
/opsx:apply
```
Implement in a clean context, making scaffolded tests pass.

```
/opsx:verify
```
Validate completeness, correctness, and coherence against the artifacts.

```
Load the post-apply skill and review the add-notification-preferences change
```
Combined quality gate with go/no-go verdict. Catches spec gaps, security issues, and debug leftovers.

```
/opsx:archive
```

---

## 4. Bug Fix

Skip the full spec pipeline. Diagnose first, then minimal spec.

```
Load the debug-investigate skill and debug this error: user sessions are expiring too early even with valid tokens
```
Chains docs lookup, GitHub solutions, AST search, and error handling audit into a structured diagnosis.

Alternatively, run individual investigation steps:

```
/opsx:explore user sessions are expiring too early even with valid tokens
```
Investigate the codebase, trace the root cause.

```
/ast-find verifyToken
```
Find all definitions, call sites, and imports of the suspected function.

```
/repo-errors
```
Check for related error handling issues nearby — bugs often have swallowed siblings.

```
/c7-fix jsonwebtoken verify options ignoreExpiration
/gh-fix jwt token expiry validation node.js
```
Look up known solutions — official docs and real-world fixes.

Once root cause is confirmed:

```
/opsx:propose fix-session-expiry
```
Minimal proposal: what's wrong, what fixes it, short `tasks.md` (1–3 tasks).

```
/opsx:apply
```
Fix in a clean context.

```
/opsx:archive
```
Skip `/opsx:verify` for small single-file fixes. Run it if the bug touched shared infrastructure.

---

## 5. Brownfield Feature (Adding to an Existing Codebase)

You need to add something new to a codebase you didn't write.

```
Load the pre-propose skill and map this codebase for OpenSpec
```
Maps auth, routes, and models. Produces a summary and suggests `config.yaml` seed content so every OpenSpec proposal respects the existing conventions.

```
/opsx:propose add invoice export to PDF
```
Write the spec informed by what actually exists.

```
/c7-docs pdfkit
/gh-examples pdfkit text and tables
```
Research the implementation approach.

```
/opsx:apply
```
Implement in a clean context.

```
/opsx:verify
```
Validate completeness against the spec.

```
Load the post-apply skill and review the add-invoice-export-to-pdf change
```
Combined quality gate with go/no-go verdict.

```
/opsx:archive
```

---

## 6. Debugging a Production Error

You have an error message or stack trace.

```
Load the debug-investigate skill and debug this error: TypeError: Cannot read properties of undefined (reading 'map')
```
Chains docs lookup, GitHub solutions, AST search, and error handling audit into a structured diagnosis with root cause hypothesis and suggested fix.

Alternatively, run individual investigation steps:

```
/c7-fix TypeError: Cannot read properties of undefined (reading 'map')
```
Check the official docs for what could cause this.

```
/gh-fix TypeError: Cannot read properties of undefined reading map react
```
Find how others solved the same error in real codebases.

```
/ast-find processNotifications
```
Find all call sites and definitions of the suspected function in your codebase.

```
/repo-errors
```
Audit the broader error handling — find other swallowed errors that might be hiding related issues.

---

## 7. Adopting a New Library

You want to add a library you haven't used before.

```
/c7-docs zod
```
Official overview: core concepts, basic usage, API surface.

```
/gh-examples zod schema validation with express middleware
```
See how production codebases integrate it — not just toy examples.

```
/gh-docs zod transform and refine
```
Combined view: official docs + real-world usage for the specific APIs you'll use.

```
/ast-find validate
```
Check if the codebase already has validation patterns you should follow or replace.

---

## 8. Refactoring Existing Code

Rename a function or change a pattern across the codebase.

```
/ast-find fetchUserData
```
Find every definition, call site, and import of the target symbol.

```
/ast-refactor fetchUserData(userId)
```
Find all sites that match the current call shape — exactly what needs to change.

```
/ast useCallback($$$ARGS)
```
Verify no related patterns were missed with a broader structural search.

```
/repo-review
```
After the refactor: catch any TODOs, debug code, or type annotation gaps introduced.

---

## 9. Upgrading a Dependency

Moving from one major version to another.

```
/c7-docs next.js
```
Check the latest docs for breaking changes and new APIs.

```
/gh-pattern next.js 15 app router
```
See how the community has already updated their code.

```
/ast-find useRouter
```
Find all usages of the old API in your codebase — scope the migration.

```
/repo-errors
```
After upgrading: check if any new error patterns were introduced.

---

## 10. Pre-commit Code Audit

Before opening a PR, make sure the code is clean.

```
/repo-review
```
Full audit: tech debt markers, debug leftovers, potential secrets, empty catches, missing return types. Fix everything flagged as Critical or High.

If working with an OpenSpec change, run the combined quality gate:

```
Load the post-apply skill and prepare to archive
```

---

## 11. Closing a Parallel Sprint

You've been running multiple OpenSpec changes in parallel and want to close them all.

```
/opsx:verify fix-login-bug
/opsx:verify add-dark-mode
/opsx:verify update-footer
```
Verify each change independently to surface any gaps.

```
/opsx:bulk-archive
```
Lists all completed changes, detects spec conflicts between them, resolves by inspecting what's actually in the codebase, and archives in chronological order.

---

## 12. Investigating an Unfamiliar Pattern

You see a pattern in the codebase you don't recognize.

```
/ast-find createServerAction
```
Find all usages in the current codebase to understand how it's used locally.

```
/gh-examples createServerAction next.js
```
See real-world examples from other projects for broader context.

```
/c7-docs next.js server actions
```
Get the official explanation.

---

## 13. Language-Scoped Analysis

Working on a polyglot codebase and need to scope searches by language.

```
/ast-lang python def $FUNC($$$ARGS)
```
Find all Python function definitions.

```
/ast-lang typescript async function $FUNC($$$ARGS)
```
Find all async TypeScript functions.

```
/ast-lang tsx useState($INIT)
```
Find all React state hooks in TSX files.

---

## When NOT to Run the Full Pipeline

| Situation | Recommended approach |
|---|---|
| Bug fix (1–3 files) | `/opsx:explore` → `/opsx:propose fix-<name>` with minimal tasks → `/opsx:apply` → `/opsx:archive` |
| Tiny fix (1 function, obvious) | Just implement it. No OpenSpec needed. |
| Spike or experiment | `/opsx:explore` only. Don't create a change. |
| Dependency bump, no API changes | Direct implementation. OpenSpec adds no value. |
| Feature touching shared infra | Full pipeline — `/opsx:verify` catches cross-module spec drift. |

**Rule of thumb:** If `tasks.md` would have only 1–2 tasks, the overhead of a full spec may not be worth it. Use `/opsx:explore` to confirm your approach, then implement directly.
