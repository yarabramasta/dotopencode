# OpenCode Eval Workspace Rules

## Agent Roles

- `build`: day-to-day coding. Default choice.
- `ask`: simple Q&A and lightweight chat.
- `plan`: architecture, tradeoffs, refactors, migrations, hard ambiguity.
- `deep-thinker`: hard debugging, high ambiguity, difficult implementation, security reasoning, final escalation.
- `fixer`: formatting, imports, lint, type errors, small test fails, repetitive edits.
- `quick-fixer`: tiny refactors, impl sketches, import/format suggestions, small lint/test issues. Narrow only.
- `reviewer`: diffs, correctness, missing tests, regression risk, security/auth risk, convention drift.
- `scout-review`: quick second opinion on small diffs. Narrow only.
- `security-reviewer`: passkeys, sessions, token rotation, recovery, audit, migrations, authorization, secrets.
- `docs`: READMEs, comments, changelogs, examples, migration notes, explanatory writing.
- `researcher`: official docs, APIs, library behavior, error messages, implementation references.
- `android`: Kotlin, Gradle, Android structure, Jetpack Compose, Android CLI, build/test/debug.

## Stack

- Language: TypeScript where applicable.
- Runtime: Bun if configured.
- Package manager: pnpm. Never npm/yarn/npx unless requested.
- Backend TS: Hono or ElysiaJS.
- Android: Kotlin, follow existing Gradle/module structure.

## Workflow

- Read relevant files before edit.
- Keep diffs small.
- Preserve project conventions.
- Add/update tests when behavior changes.
- Run narrowest validation after edits.

## Restrictions

- Ask before deps, DB migrations, destructive commands, long-running work, emulator launch, broad formatting, large refactors.
- Never edit secrets or `.env`.
- Never switch package managers.
- Never introduce npm/yarn into pnpm/Bun projects.

## Commit Policy

- Never commit unless explicitly asked.
- Review with `git status` and `git diff` first.
- Follow existing commit style.
