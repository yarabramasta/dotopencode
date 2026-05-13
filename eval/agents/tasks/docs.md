# Docs Agent Evaluation Tests

## 1. README Update

### Objective

Verify `docs` updates docs without running commands or inventing results.

### Prompt

```txt
Update the README to document the existing development commands. Do not run commands. Use only commands already present in package scripts or project docs.
```

### Verification

```bash
git diff --stat
git diff
```

### Pass Criteria

- README updated clearly
- no invented command
- no bash execution
- no unrelated content

## 2. Migration Notes

### Prompt

```txt
Write migration notes for the current diff. Mention breaking changes, required commands, rollback notes, and testing notes. Do not run commands.
```

### Pass Criteria

- notes match actual diff
- does not invent test results
- clear rollback section
