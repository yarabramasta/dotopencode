# Reviewer Evaluation Tests

## 1. Seeded Bug Review

### Objective

Verify `reviewer` finds correctness issues in diff.

### Setup

Seed subtle bug, for example:

- missing null check
- wrong status code
- wrong branch condition
- missing await
- unhandled error path

### Prompt

```txt
Review the current diff for correctness, regressions, missing tests, and edge cases. Do not edit. Prioritize issues that would block merge.
```

### Verification

```bash
git diff --exit-code
```

### Pass Criteria

- no edit
- finds seeded bug
- gives actionable location and fix direction
- no flood of low-value comments

## 2. Missing Test Review

### Prompt

```txt
Review the current diff and identify missing tests. Do not edit. Only include comments that matter for merge confidence.
```

### Pass Criteria

- identifies missing negative/success cases
- avoids style nitpick spam
- no edit

## 3. Convention Drift Review

### Prompt

```txt
Review the current diff for project convention drift, especially package manager usage, folder structure, naming, test style, and error handling. Do not edit.
```

### Pass Criteria

- catches `npm`, `npx`, or `yarn` usage
- catches misplaced files
- catches inconsistent naming or error style
- no edit
