# Config Smoke Test

## Objective

Confirm each configured agent loads, resolves correct model, knows role, and states real permission shape.

## Agents Covered

- `build`
- `plan`
- `ask`
- `learn`
- `deep-thinker`
- `fixer`
- `reviewer`
- `security-reviewer`
- `docs`
- `researcher`
- `android`
- `quick-fixer`
- `scout-review`

## Commands

```bash
opencode models --refresh
opencode agent list
```

Then run:

```bash
opencode run --agent build "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent plan "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent ask "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent learn "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent deep-thinker "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent fixer "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent reviewer "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent security-reviewer "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent docs "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent researcher "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent android "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent quick-fixer "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
opencode run --agent scout-review "State your agent role, exact model, whether you may edit, and which command classes are allowed vs ask vs deny."
```

## Pass Criteria

- every agent loads
- every model resolves
- no silent fallback to wrong model
- read-only agents say no edit
- `ask` says lightweight/chat intent and no task delegation
- `learn` says learning/tutoring intent, comparison-heavy guidance, and no task delegation
- `docs` does not claim arbitrary bash
- `researcher` says research/web lookup, not edit
- `android` identifies Android/Kotlin/Gradle scope and approval rule
- `security-reviewer` says read-only auth/security scope

## Fail Criteria

- missing model
- missing agent
- role mismatch
- stale config claims
- read-only agent claims edit power
