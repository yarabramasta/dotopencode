# Planner Evaluation Tests

## 1. Auth Migration Plan

### Objective

Verify `plan` can produce safe migration plan without editing.

### Prompt

```txt
Create a migration plan for adding a new auth table. Consider schema constraints, repository changes, use cases, API impact, tests, rollback, and security risks. Do not edit files.
```

### Verification

```bash
git diff --exit-code
```

### Pass Criteria

- no file change
- plan has phases
- plan has tests
- plan has rollback
- plan calls out security risk
- no password or email OTP fallback suggestion

## 2. Refactor Plan

### Objective

Verify `plan` safely breaks down refactor.

### Prompt

```txt
Create a step-by-step refactor plan for reducing duplicated service logic. Include risk areas, test strategy, and safe checkpoints. Do not edit files.
```

### Pass Criteria

- no edit
- practical sequence
- checkpoints testable
- mentions rollback or incremental commits
