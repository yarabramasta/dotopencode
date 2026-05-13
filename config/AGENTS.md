# Global opencode agent rules

## Agent orchestration

### Core agents
- **build**: Day-to-day coding. Default choice.
- **ask**: Simple question answering chatbot for lightweight conversational tasks to save tokens.
- **plan**: Architecture, tradeoffs, refactor plans, migrations, high-ambiguity, big work breakdowns. Read first, avoid editing.
- **deep-thinker**: Hard debugging, high-ambiguity design, difficult impl, security reasoning, final escalation. On request only.

### Delegate matrix

| Task Type | Agent | What |
|-----------|-------|------|
| Mechanical fixes | **fixer** | Format, imports, lint, type errors, small test fails, repetitive edits, simple refactors |
| Code attempts | **quick-fixer** | Tiny refactors, impl sketches, import/format suggestions, quick alts, small lint/test issues. Narrow & non-sensitive only. NO: auth, security, biz logic, broad rewrites, arch, deps, DB, long-running |
| Review | **reviewer** | Git diffs, correctness, missing tests, regression risk, security/auth risk, convention drift |
| Quick review | **scout-review** | Small diff review, bug spotting, naming, edge cases, lightweight risk. Narrow & non-sensitive only. NO: secrets, auth/security, biz logic, production approval, long reviews, arch |
| Security review | **security-reviewer** | Passkeys, sessions, refresh-token rotation, recovery codes, audit events, migrations, authorization, secrets, and destructive operations |
| Docs | **docs** | READMEs, comments, docstrings, changelogs, examples, migration notes, explanatory writing |
| Research | **researcher** | Official docs, API/lib behavior, dependency behavior, error messages, impl references |
| Android | **android** | Kotlin, Gradle, Android project structure, Jetpack Compose, Android CLI, build/test/debug workflows. Ask before heavy Gradle/emulator/device commands |

---

## Stack preferences

- **Language**: TypeScript where applicable
- **Runtime**: Bun if configured
- **Package manager**: pnpm always. Never npm/yarn/npx unless requested
- **Backend TS**: Hono or ElysiaJS
- **Android**: Kotlin, follow existing Gradle/module structure

---

## Workflow

### Before edit
- Read relevant files
- Understand code conventions
- Mimic existing style, libraries, patterns

### During edit
- Small diffs. Avoid broad rewrites unless requested
- Preserve project conventions
- Add/update tests when behavior changes
- Run narrowest validation after edits (lint, typecheck, etc.)

### Restrictions
- Ask before: deps, DB migrations, destructive commands, long-running, emulator launch, broad formatting, large refactors
- Never: edit secrets/`.env`, switch package managers, introduce npm/yarn into pnpm/Bun projects

### Commit policy
- Never commit unless explicitly asked
- Use `git status` + `git diff` to review changes first
- Follow existing commit message style
