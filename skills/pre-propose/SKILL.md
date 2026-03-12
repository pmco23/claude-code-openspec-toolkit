---
name: pre-propose
description: This skill maps a codebase's auth, routes, and models before proposing an OpenSpec change. It uses ast-grep and Grep to discover architecture conventions and suggests openspec/config.yaml seed content. This skill should be used before the first /opsx:propose on a new or unfamiliar project, when asked to "map this codebase for OpenSpec", or when onboarding to a brownfield codebase.
---

## What I do

Before writing an OpenSpec proposal, map the codebase so the spec reflects what actually exists. This avoids proposals that clash with existing conventions, duplicate endpoints, or miss auth requirements.

### Step 1 — Map authentication and authorization

Use the ast-grep MCP tool and Grep to find:
- Auth middleware (JWT, session, OAuth, API key patterns)
- Authorization checks (role guards, permission checks, RBAC/ABAC)
- Auth-related config (env vars, secret references)

Summarize: What auth strategy is used? Where are guards applied? What patterns should new code follow?

### Step 2 — Map API routes and endpoints

Use the ast-grep MCP tool and Grep to find:
- All HTTP endpoint definitions (Express, Fastify, Next.js, Django, Flask, Rails, etc.)
- Route grouping and middleware chains
- API versioning patterns

Summarize: What's the routing convention? What prefixes exist? Where should new endpoints go?

### Step 3 — Map database models and schemas

Use the ast-grep MCP tool and Grep to find:
- ORM model definitions (Prisma, Drizzle, SQLAlchemy, ActiveRecord, etc.)
- Migration files and schema definitions
- Relationships between models

Summarize: What ORM is used? What naming convention do models follow? What relationships exist?

### Step 4 — Produce summary report

Combine findings into a structured summary:

```
## Codebase Map for OpenSpec

### Auth
- Strategy: [JWT / session / OAuth / etc.]
- Guard pattern: [middleware name and location]
- Key files: [list]

### Routes
- Framework: [Express / Next.js / etc.]
- Convention: [/api/v1/resource / etc.]
- Existing endpoints: [count and groupings]
- Key files: [list]

### Models
- ORM: [Prisma / Drizzle / etc.]
- Naming: [PascalCase / snake_case / etc.]
- Models: [list with relationships]
- Key files: [list]

### Conventions to Respect
- [bullet list of patterns new code should follow]
```

### Step 5 — Suggest config.yaml seed

If `openspec/config.yaml` does not exist, suggest seed content based on discovered patterns. Use the official OpenSpec config format (`schema`, `context`, `rules`) plus the `toolkit:` namespace for OpenSpec Toolkit settings:

```yaml
# openspec/config.yaml
schema: spec-driven

context: |
  Tech stack: <detected language>, <detected framework>
  Auth: <detected auth pattern>
  ORM: <detected ORM>
  Routing: <detected routing convention>
  Naming: <detected naming patterns>

rules:
  specs:
    - Reference existing patterns before inventing new ones
  tasks:
    - Include testable acceptance criteria (Given/When/Then)

# OpenSpec Toolkit settings (optional)
toolkit:
  security-scan: true        # false to skip security pass in post-apply
  tdd-enforce: auto           # auto | always | never
  custom-secret-patterns: []  # additional regex patterns for secret detection
  skip-quality-patterns: []   # file patterns to exclude from quality scans
```

Write this suggestion to the conversation output — do NOT write the file automatically. Let the user review and adjust before saving.

### Step 6 — Save key findings to memory

Save the codebase map summary to Claude Code's auto-memory system (write a memory file to the `.claude/projects/` memory directory) so future sessions don't need to re-derive it. Include the auth strategy, routing convention, ORM, and key file paths.

## When to use me

- Before the first `/opsx:propose` on a new or unfamiliar project
- When asked to "map this codebase for OpenSpec"
- When onboarding to a brownfield codebase before writing specs

```
Load the pre-propose skill and map this codebase for OpenSpec
```
