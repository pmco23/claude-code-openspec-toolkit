---
name: test-scaffold
description: This skill extracts acceptance criteria from OpenSpec tasks.md and scaffolds test files with assertion placeholders for TDD. This skill should be used before implementing a task during /opsx:apply, when asked to "scaffold tests" or "set up TDD", or when starting TDD on an OpenSpec change.
---

## What I do

Read an OpenSpec `tasks.md` and scaffold test files with one test case per acceptance criterion, ready for TDD red-green-refactor.

### Step 1 — Find the tasks

1. If a change name was provided, read `openspec/changes/<name>/tasks.md`
2. Otherwise, find the most recently modified non-archived change folder under `openspec/changes/`
3. Parse all tasks and their acceptance criteria

### Step 2 — Detect the test framework

Check the project for:
- `package.json` → look for `jest`, `vitest`, `mocha`, `@testing-library/*` in dependencies/devDependencies
- `pyproject.toml` or `setup.cfg` → look for `pytest`, `unittest`
- `Cargo.toml` → Rust built-in tests
- `go.mod` → Go built-in tests
- Existing test files → match the naming convention (`*.test.ts`, `*_test.go`, `test_*.py`, etc.)

Use the detected framework and existing test patterns to match the project's conventions.

### Step 3 — Extract testable criteria

For each task in `tasks.md`, extract acceptance criteria:
- **Given/When/Then** blocks → one test per Then clause
- **Expected values** (returns X, status 200, creates Y) → one test per expectation
- **Edge cases** mentioned → one test per edge case
- **Vague criteria** (no measurable outcome) → skip with a note: `// Skipped: no testable criteria in tasks.md`

### Step 4 — Scaffold test files

For each task with testable criteria, create a test file:
- Place it following the project's test file convention (co-located `__tests__/`, top-level `tests/`, or alongside source)
- Use the project's test framework syntax
- Structure:

```
describe('Task <id>: <task title>', () => {
  it('<acceptance criterion 1>', () => {
    // TODO: implement — from tasks.md task <id>
    // Given: <precondition>
    // When: <action>
    // Then: <expected outcome>
  });

  it('<acceptance criterion 2>', () => {
    // TODO: implement — from tasks.md task <id>
  });
});
```

- Include imports for the test framework
- Add a comment linking back to the tasks.md task ID
- Use `TODO: implement` as the assertion placeholder so it's easy to find

### Step 5 — Output summary

Report:
```
## Test Scaffold Summary: <change-name>

### Scaffolded
- `tests/task-1-user-preferences.test.ts` — 3 test cases
- `tests/task-2-notification-api.test.ts` — 5 test cases

### Skipped (no testable criteria)
- Task 4: "Update documentation" — no measurable outcome

### Next steps
1. Run the tests — they should all FAIL (red phase)
2. Implement the minimum code to make each test pass (green phase)
3. Refactor after green without changing behavior
```

## When to use me

- Before implementing tasks during `/opsx:apply` — scaffold tests first for TDD
- When starting TDD on an OpenSpec change
- When asked to "scaffold tests", "set up TDD", or "generate test stubs"

```
Load the test-scaffold skill and scaffold tests for the add-dark-mode change
```

Or for the most recent change:

```
Load the test-scaffold skill and scaffold tests for the current change
```
