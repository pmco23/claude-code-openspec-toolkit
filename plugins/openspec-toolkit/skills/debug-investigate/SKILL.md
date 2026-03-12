---
name: debug-investigate
description: This skill runs a structured debugging workflow that chains documentation lookup, GitHub solutions search, AST code search, and error handling audit to diagnose an error or symptom. This skill should be used when debugging a specific error message, exception, or unexpected behavior, when /c7-fix or /gh-fix alone aren't enough, or when asked to "investigate" or "diagnose" an error.
---

## What I do

Given an error message or symptom, run a structured investigation combining documentation, community solutions, and codebase analysis to produce a diagnosis with root cause hypothesis and suggested fix.

### Step 1 — Understand the error

Parse the error message or symptom provided by the user. Identify:
- The error type (TypeError, ImportError, HTTP 500, etc.)
- The suspected library or framework
- Any function names or file paths mentioned

### Step 2 — Check official documentation

Use the context7 MCP tools (`resolve-library-id` then `query-docs`) to look up:
- The error type in the relevant library docs
- The API or function mentioned in the error
- Known gotchas, migration notes, or breaking changes

Summarize what the docs say about this error.

**Fallback:** If context7 MCP tools are unavailable, use WebSearch to look up the official documentation for the relevant library and error type.

### Step 3 — Find real-world solutions

Use the gh_grep MCP tool (`searchGitHub`) to search for:
- The exact error message (or a distinctive portion of it)
- The error combined with the framework name
- Related issue titles and fix commits

Summarize the most relevant solutions found.

**Fallback:** If gh_grep MCP tool is unavailable, use WebSearch to find GitHub issues, Stack Overflow threads, and community solutions for the error.

### Step 4 — Locate the code in the codebase

Use the ast-grep MCP tool to find:
- The function mentioned in the error or stack trace (definitions, call sites, imports)
- Related patterns around the suspected location

If no specific function is mentioned, use Grep to search for the error message string in the codebase.

### Step 5 — Audit related error handling

Use Grep to scan the area around the suspected code for:
- Empty catch blocks that might be swallowing related errors
- Missing null checks on the object chain leading to the error
- Related TODO/FIXME comments that hint at known issues

### Step 6 — Produce diagnosis

Combine all findings into a structured diagnosis:

```
## Diagnosis: <error summary>

### Error
<the original error message>

### Root Cause Hypothesis
<what is most likely causing this, based on docs + community + codebase analysis>

### Evidence
- Docs say: <relevant finding>
- GitHub shows: <relevant solution pattern>
- Codebase: <what was found at the suspected location>

### Suggested Fix
<specific code change or approach to resolve the issue>

### Files to Check
- <file:line> — <why>

### Related Issues Found
- <any swallowed errors, missing checks, or TODOs found nearby>
```

## When to use me

- When you have a specific error message or stack trace to debug
- When you see unexpected behavior and want a structured investigation
- When `/c7-fix` or `/gh-fix` alone aren't enough and you need the full chain

```
Load the debug-investigate skill and debug this error: Cannot read properties of undefined (reading 'map')
```

Or with a symptom:

```
Load the debug-investigate skill and investigate: user sessions expire after 5 minutes despite 24h config
```
