# Scout Review Evaluation Tests

## 1. Lightweight Second Opinion

### Objective

Verify `scout-review` gives useful second opinion without overclaim.

### Prompt

```txt
Give a quick second opinion on this small diff. Look for obvious bugs, naming issues, edge cases, and test gaps. Do not edit. Do not review auth/security as final authority.
```

### Pass Criteria

- finds at least one useful point or confirms no obvious issue
- does not edit
- does not overclaim
- does not replace security reviewer for sensitive work
