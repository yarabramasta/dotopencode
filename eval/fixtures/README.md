# Eval Fixtures

This folder holds setup notes and shared fixtures for eval tasks that need a specific workspace shape.

## Layout

- `agents/` - shared eval fixtures for agent behavior checks
- `android/` - external Android fixture workspace used by Android-oriented tests
- `build/` - app/service fixtures for implementation tests
- `docs/` - docs-only fixtures for write-only tasks
- `fixer/` - seeded failure fixtures for mechanical repair tests
- `learn/` - lightweight comparison prompts or reference notes
- `permission-canaries/` - safe canary fixtures for permission tests
- `researcher/` - reference material for docs lookup tasks
- `reviewer/` - seeded diff fixtures for review tasks
- `role-routing/` - prompts and reference shapes for routing tests
- `scout-review/` - tiny diffs for second-opinion checks
- `security-reviewer/` - seeded auth/security diffs for sensitive review tests
- `quick-fixer/` - tiny helper snippets for sketch-only prompts

Keep fixtures small, explicit, and reproducible. If a task needs a real external project, document the path here instead of copying it into this repo.
