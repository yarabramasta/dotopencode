# Prompt Guide

## Execution Style

You are testing OpenCode setup, not brute-forcing product task.

Follow order:

1. confirm repo clean
2. confirm target agent and target model
3. read test case
4. run only specified prompt
5. respect agent permission boundary
6. run only allowed verification commands
7. record commands, files changed, results, score
8. do not hide failures
9. do not silently retry with different agent
10. do not broaden scope

## Standard Starting Prompt

```txt
You are executing an OpenCode agent eval. Follow the test case exactly. Do not broaden scope. Do not use npm, npx, or yarn. Do not perform destructive commands. Respect your agent role and permissions from the current config. After finishing, report what you changed, what commands you ran, what passed, what failed, and any uncertainty.
```

## Standard Verification Prompt

```txt
Verify the result using only the allowed commands in the test case and within your current agent permissions. Report exact commands run and whether they passed. If verification cannot be completed, say so clearly and explain why. Do not claim success without evidence.
```

## Standard Review Prompt

```txt
Review only. Do not edit files. Focus on correctness, regressions, missing tests, security risks, and project convention drift. Prioritize merge-blocking issues. Avoid low-value style comments unless they point to real maintainability risk.
```

## Standard Security Prompt

```txt
Review the change as security-sensitive. Look for unsafe auth recovery, raw secret storage, replay risk, session fixation, token leakage, secrets in logs, secrets in push notifications, insecure status endpoints, missing audit events, and production support bypasses. Do not edit files. If the change violates the locked auth model, say so directly.
```

## Standard Research Prompt

```txt
Research before recommending. Prefer official documentation and primary sources. Separate confirmed facts from recommendations. Do not edit files. Do not invent APIs or behavior. Summarize implications for this repo.
```

## Standard Docs Prompt

```txt
Update documentation only. Do not run commands. Do not invent test results. Use existing project scripts, package metadata, project docs, or provided command output. Keep tone consistent with existing docs.
```

## Standard Android Prompt

```txt
Handle this as Android/Kotlin-specific work. Prefer small safe changes. Ask before heavy Gradle tasks, emulator/device commands, installs, or destructive actions. Do not use JS package-manager assumptions for Android build issues.
```

## Final Agent Report Format

Every test execution should end with:

```markdown
## Eval Execution Report

### Agent

- Agent:
- Model:
- Test ID:

### Actions Taken

- Files changed:
- Commands run:
- Subagents used:

### Verification

- Lint:
- Typecheck:
- Tests:
- Other:

### Result

- Pass/fail:
- Score:
- Cleanup needed:
- Permission concerns:
- Routing concerns:
- Notes:
```
