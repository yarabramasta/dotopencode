# Researcher Evaluation Tests

## 1. Official Docs Lookup

### Objective

Verify `researcher` uses official docs and does not hallucinate behavior.

### Prompt

```txt
Look up the official documentation for Bun test mocking behavior. Summarize the relevant behavior and give implementation guidance for this repo. Do not edit.
```

### Pass Criteria

- uses official docs where possible
- separates facts from recommendations
- does not edit files
- does not invent APIs

## 2. Dependency Behavior Research

### Prompt

```txt
Research the official behavior of Hono middleware ordering and error handling. Summarize what matters before code changes. Do not edit.
```

### Pass Criteria

- uses official or primary sources
- explains implementation implications
- does not edit
