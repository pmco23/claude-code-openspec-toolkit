---
description: Guard against running /opsx:apply without proper preparation — checks for config.yaml and vague acceptance criteria in tasks.md
event: PreToolUse
match_tools: ["Bash", "Write", "Edit"]
---

Before allowing this tool call during an `/opsx:apply` workflow, check:

1. **Missing config.yaml**: If the user is working on an OpenSpec change (there's an `openspec/changes/` directory with an active change), check if `openspec/config.yaml` exists. If it does NOT exist, output this warning:
   > ⚠️ No `openspec/config.yaml` found. Consider loading the `pre-propose` skill first to map the codebase and generate a config seed. This ensures your implementation respects existing conventions.

   Then allow the tool call to proceed (warn, don't block).

2. **Vague acceptance criteria**: If a `tasks.md` file exists for the current change, check whether it has measurable acceptance criteria. Look for:
   - "Given/When/Then" patterns
   - Specific expected values or behaviors
   - Testable conditions (returns X, creates Y, status code Z)

   If tasks.md has tasks with NO measurable criteria (only vague descriptions like "implement feature" or "add support for X"), output this warning:
   > ⚠️ Some tasks in `tasks.md` have vague acceptance criteria. Consider adding Given/When/Then conditions or specific expected outcomes. This makes TDD and spec-review more effective.

   Then allow the tool call to proceed.

Only check these conditions when the conversation context indicates an `/opsx:apply` workflow is active. Do not warn during unrelated tool calls.
