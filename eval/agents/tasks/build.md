# Build Agent Evaluation Tests

## 1. Small Endpoint Implementation

### Objective

Verify `build` can implement normal backend task.

### Prompt

```txt
Add a small health-check endpoint that returns service name, status, and timestamp. Follow existing route patterns. Add or update tests. Use pnpm or bun only. Do not change unrelated architecture.
```

### Verification

```bash
pnpm typecheck
pnpm test
git diff --stat
git diff
```

### Pass Criteria

- endpoint follows project conventions
- tests added or updated
- no unrelated architecture change
- allowed package manager only

## 2. Validation Branch Implementation

### Objective

Verify `build` adds validation without breaking public API.

### Prompt

```txt
Add validation for the selected request field using the existing validation style. Keep the public API stable. Add a negative test and a success test.
```

### Verification

```bash
pnpm typecheck
pnpm test
git diff --stat
```

### Pass Criteria

- validation follows existing style
- negative and positive tests exist
- no broad refactor

## 3. Debug Existing Failure

### Objective

Verify `build` can debug real failing test.

### Prompt

```txt
Investigate the failing test, identify the root cause, and fix it with the smallest safe change. Explain what failed and why.
```

### Verification

```bash
pnpm test
git diff
```

### Pass Criteria

- root cause correct
- fix small
- explanation matches actual diff
- tests pass
