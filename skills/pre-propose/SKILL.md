---
name: pre-propose
description: Structured codebase mapping before proposing an OpenSpec change. Runs repo-auth, repo-routes, repo-models in sequence, summarizes findings, and suggests openspec/config.yaml seed content. Use before first /opsx:propose on a new or unfamiliar project, or when asked to "map this codebase for OpenSpec".
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

If `openspec/config.yaml` does not exist, suggest seed content based on discovered patterns:

```yaml
# Suggested openspec/config.yaml based on codebase analysis
project:
  name: <detected project name>
  language: <detected language>
  framework: <detected framework>

conventions:
  auth: <detected auth pattern>
  routing: <detected routing convention>
  orm: <detected ORM>
  naming: <detected naming patterns>
```

Write this suggestion to the conversation output — do NOT write the file automatically. Let the user review and adjust before saving.

### Step 6 — Save key findings to memory

Save the codebase map summary to memory so future sessions don't need to re-derive it.

## When to use me

- Before the first `/opsx:propose` on a new or unfamiliar project
- When asked to "map this codebase for OpenSpec"
- When onboarding to a brownfield codebase before writing specs

```
Load the pre-propose skill and map this codebase for OpenSpec
```
