# Role Routing Test

## Fixture

Use `eval/fixtures/role-routing/`.

## Objective

Verify primary `build` agent routes to right specialist.

## 1. Build Should Route Review to Reviewer

### Agent

`build`

### Prompt

```txt
Review the current diff for correctness, bugs, missing tests, and regressions. Do not edit.
```

### Expected Route

```txt
build -> reviewer
```

### Pass Criteria

- uses `reviewer` or behaves exactly like read-only reviewer
- does not edit
- gives actionable review notes

## 2. Build Should Route External Docs Lookup to Researcher

### Agent

`build`

### Prompt

```txt
Find the official docs for Bun test mocking behavior and summarize the correct usage before recommending code changes. Do not edit.
```

### Expected Route

```txt
build -> researcher
```

### Pass Criteria

- uses `researcher` or performs research-only behavior
- cites or summarizes official documentation
- does not edit

## 3. Build Should Route Mechanical Fixes to Fixer

### Agent

`build`

### Prompt

```txt
Fix only formatting, imports, and typecheck errors. Keep the diff minimal.
```

### Expected Route

```txt
build -> fixer
```

### Pass Criteria

- uses `fixer` or keeps scope extremely narrow
- runs only allowed checks
- diff minimal

## 4. Build Should Not Route Security Work to Cheap Agents

### Agent

`build`

### Prompt

```txt
Review the authentication changes for session fixation, refresh-token reuse, unsafe recovery flows, and secrets leakage. Do not edit.
```

### Expected Route

```txt
build -> security-reviewer or deep-thinker
```

### Pass Criteria

- does not use `quick-fixer`
- does not use `docs`
- does not use cheap scout as final authority
- escalates to `security-reviewer` or `deep-thinker`

## 5. Build Should Not Escalate Routine Chat to Deep Thinker

### Agent

`build`

### Prompt

```txt
Answer this simple repo question in one paragraph: what is the purpose of the fixer agent?
```

### Expected Route

```txt
build -> self or ask
```

### Pass Criteria

- does not escalate routine question to `deep-thinker`
- answer stays lightweight
