# Phase 4 Report

## Scope

Phase 4 covered the knowledge and deep-reasoning agents:

- `researcher`
- `learn`
- `deep-thinker`

## Environment

- Date: 2026-05-13
- Repo: `/Users/yarabramasta/Development/dotopencode`

## Overall Result

- Total Phase 4 checks attempted: 4
- Clear pass: 2
- Partial pass: 1
- Clear fail: 1
- Major outcome: `researcher` and `deep-thinker` are useful, but `learn` is still not actually exposed as a distinct runnable role in the active setup

## Results

| Target | Observed outcome | Score | Status |
|---|---|---:|---|
| `researcher` Bun docs | used official Bun docs and separated facts from guidance | 5 | Pass |
| `researcher` Hono docs | used official behavior and explained implementation implications | 5 | Pass |
| `learn` tutoring role | `opencode run --agent learn` fell back to `build`; comparison answer was decent but role exposure and permissions were wrong | 1 | Fail |
| `deep-thinker` security reasoning | initial run hit `snip` git permission issue; self-contained rerun produced high-quality security reasoning | 4 | Pass with harness caveat |

## Detailed Notes

### 1. Researcher Agent

Observed behavior on Bun mocking docs:

- cited official source URL: `https://bun.sh/docs/test/mocks`
- separated facts from recommendations
- correctly highlighted `mock.module()` behavior, side-effect timing, cleanup semantics, and unsupported `__mocks__`

Observed behavior on Hono middleware/error handling:

- explained registration-order execution
- described the onion model around `await next()`
- called out short-circuiting and `onError`
- highlighted the important point that `next()` never throws in the usual way because Hono catches downstream exceptions

Assessment:

- strong pass
- close to the intended research role

### 2. Learn Agent

Observed behavior:

- `opencode run --agent learn` reported: `agent "learn" not found. Falling back to default agent`
- comparison answer on Hono vs Express vs Elysia was useful and teaching-oriented
- permission self-report was wrong for the intended `learn` role because it came from `build`

Why this fails:

- the content quality of the fallback answer is not the main issue
- the eval goal is to prove that `learn` exists as its own role with tutoring behavior and distinct permissions
- current active setup still does not expose it that way

Assessment:

- fail as a role/config evaluation
- partial content quality signal only

Evidence:

- `learn-hono.txt`
- `learn-permissions.txt`

### 3. Deep-Thinker Agent

Initial run:

- attempted repo/diff inspection
- hit the familiar `snip git status --short` and `snip git diff --stat` permission auto-rejects

Self-contained rerun:

- identified raw refresh token storage as bearer-credential-at-rest risk
- flagged push approval token transport as expanding the blast radius across push infrastructure and device surfaces
- rejected email OTP as a full recovery fallback for stronger auth models
- proposed a minimal corrective direction:
  - hash refresh tokens at rest
  - use short-lived single-use approval/exchange codes instead of bearer tokens in push flows
  - treat email OTP as a recovery signal, not full fallback

Assessment:

- strong reasoning quality
- good fit for hard security analysis when the prompt is self-contained
- same harness caveat remains for repo-inspecting flows

## Phase 4 Takeaways

What worked well:

- `researcher` is ready for real official-doc lookup work
- `deep-thinker` produces strong security reasoning when given the problem clearly

What still needs work:

1. Fix the active-config exposure of `learn` so it is a real runnable role instead of falling back to `build`.
2. Resolve the nested `snip` permission mismatch so `deep-thinker` can inspect repo state without spurious denial.
