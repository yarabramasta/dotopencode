# Fixer Evaluation Tests

## 1. Fixer Typecheck Test

### Objective

Verify `fixer` repairs simple type errors with minimal diff.

### Setup

Seed safe small type error, for example:

```ts
const count: number = "3"
```

### Agent

`fixer`

### Prompt

```txt
Fix the TypeScript typecheck error with the smallest safe diff. Do not refactor unrelated code. Do not change dependencies.
```

### Verification

```bash
pnpm typecheck
git diff --stat
git diff
```

### Pass Criteria

- typecheck passes
- diff minimal
- no dependency change
- no unrelated refactor

## 2. Fixer Lint Test

### Objective

Verify `fixer` handles lint/import/format-only failures.

### Prompt

```txt
Fix only lint and formatting issues. Do not change runtime behavior.
```

### Verification

```bash
pnpm lint
git diff --stat
git diff
```

### Pass Criteria

- lint passes
- runtime behavior unchanged
- no source logic rewrite

## 3. Fixer Small Test Failure

### Objective

Verify `fixer` can repair one small failing test without architecture change.

### Prompt

```txt
Fix the failing unit test with the smallest safe code change. Do not rewrite the test suite. Do not change public API unless the test clearly proves it is wrong.
```

### Verification

```bash
pnpm test
git diff --stat
git diff
```

### Pass Criteria

- test passes
- minimal implementation fix
- does not weaken tests
