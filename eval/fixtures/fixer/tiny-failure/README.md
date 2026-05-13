# Tiny Failure Fixture

Minimal seeded failure fixture for fixer evals.

Current seeded issue:

- `formatName("Yara", undefined)` returns `"Yara undefined"` instead of `"Yara"`.

Validation:

- `node --test`
