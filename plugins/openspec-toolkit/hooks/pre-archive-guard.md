---
description: Guard against archiving an OpenSpec change without running a quality review first
event: PreToolUse
match_tools: ["Bash"]
---

Before allowing a Bash tool call that runs `/opsx:archive` or `opsx:bulk-archive`, check if a quality review was performed in the current session.

Look through the conversation history for evidence that one of these was run:
- The `post-apply` skill was loaded and produced a Go/No-Go report
- The `spec-review` skill was loaded and produced a review report
- `/opsx:verify` was run

If NONE of these reviews were detected in the current conversation, output this warning:
> ⚠️ No quality review detected in this session. Consider loading the `post-apply` skill (full quality gate) or `spec-review` skill (lighter review) before archiving. This catches spec gaps, security issues, and code quality problems.

Then allow the archive command to proceed (warn, don't block).

If a review WAS detected, allow the command silently.
