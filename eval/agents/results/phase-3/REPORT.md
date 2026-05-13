# Phase 3 Report

## Scope

Phase 3 covered the analysis-oriented agents:

- `plan`
- `reviewer`
- `security-reviewer`
- `scout-review`

`researcher` was executed in the same overall batch and is reported in Phase 4 alongside `learn` and `deep-thinker`.

## Environment

- Date: 2026-05-13
- Repo: `/Users/yarabramasta/Development/dotopencode`
- Fixtures used:
  - `eval/fixtures/reviewer/seeded-bug.diff`
  - `eval/fixtures/security-reviewer/token-storage.diff`
  - `eval/fixtures/scout-review/small-diff.diff`

## Overall Result

- Total Phase 3 checks attempted: 5
- Clear pass: 4
- Partial pass: 1
- Major outcome: the read-only review specialists are the strongest part of the current setup; `plan` reasoning is good once the prompt is self-contained, but nested command wrapping still hurts its default flow

## Results

| Target | Observed outcome | Score | Status |
|---|---|---:|---|
| `plan` auth migration | initial run hit `snip` bash permission auto-reject; self-contained rerun produced a complete phased plan | 4 | Pass with harness caveat |
| `plan` refactor plan | initial run hit `snip` bash permission auto-reject | 2 | Inconclusive |
| `reviewer` | found missing `await`, broken null check, runtime risk, and deleted negative test | 5 | Pass |
| `security-reviewer` | flagged raw token storage, push token leakage, and unsafe email OTP recovery | 5 | Pass |
| `scout-review` | identified the `min > max` behavior change and test gap without overclaiming | 5 | Pass |

## Detailed Notes

### 1. Plan Agent

Initial behavior on both plan prompts:

- tried `snip ls -la`
- permission was auto-rejected
- produced no useful planning output

This is the same nested-wrapper problem observed in Phase 1.

Self-contained rerun result:

- produced a phased auth-table migration plan
- covered schema, repository changes, use cases, API impact, tests, rollback, and security risks
- stayed read-only

Strengths:

- practical structure
- includes tests and rollback
- calls out token exposure and API response safety

Caveats:

- suggested storing a nullable `refresh_token` column and later described encrypting tokens at rest; that is weaker than the stricter token-hashing posture used elsewhere in the eval suite

Assessment:

- reasoning quality is solid
- default execution path is still degraded by the `snip` permission mismatch

Evidence:

- `plan-auth-migration.txt`
- `plan-auth-migration-self-contained.txt`
- `plan-refactor.txt`

### 2. Reviewer Agent

Fixture:

- `eval/fixtures/reviewer/seeded-bug.diff`

Observed findings:

- caught removal of `await` from `repo.findById`
- explained that the null check becomes ineffective because the Promise is truthy
- flagged runtime/property access risk
- identified removal of the missing-user negative test as a regression-hiding move

Assessment:

- strong pass
- exactly the kind of merge-blocking feedback the role is supposed to produce

### 3. Security Reviewer Agent

Fixture:

- `eval/fixtures/security-reviewer/token-storage.diff`

Observed findings:

- raw refresh token storage in DB
- refresh token exposure in push approval response
- unsafe email OTP recovery fallback

Assessment:

- strong pass
- high-signal, security-specific, and appropriately blocking

### 4. Scout Review Agent

Fixture:

- `eval/fixtures/scout-review/small-diff.diff`

Observed findings:

- caught changed behavior when `min > max`
- recommended clarifying/locking intended invalid-range behavior
- asked for a focused test addition
- kept confidence bounded instead of overclaiming

Assessment:

- strong pass
- good lightweight second-opinion behavior

## Phase 3 Takeaways

What worked well:

- `reviewer`, `security-reviewer`, and `scout-review` all behaved close to the intended role definitions
- seeded fixtures make these agents much easier to evaluate honestly

What still needs work:

1. `plan` should not need filesystem probing for purely conceptual prompts.
2. The `snip` command wrapper still breaks some allowed command patterns for nested primary-agent execution.
3. Add a dedicated refactor-plan fixture so the second plan prompt can be judged on output rather than harness behavior.
