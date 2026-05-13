# OpenCode Agent Eval Report

## Summary

- Date: 2026-05-13
- Repo: `/Users/yarabramasta/Development/dotopencode`
- Config variant: current local config plus external Android fixture at `~/Development/kopkarpay/member-app`
- Number of tests: 33 attempted across 4 phases
- Passed: 13 clear pass
- Failed: 11 clear fail
- Average score: approximately `3.2/5`
- Major regressions:
  - `learn` is still not exposed as a distinct runnable role and falls back to `build`
  - nested `snip` command wrapping still breaks allowed `git`/`ls` permission patterns for some primary-agent runs
  - `ask` self-reported permissions incorrectly in smoke testing
  - `build`/`fixer` implementation evals still need dedicated runnable fixtures
- Recommended changes:
  - expose `learn` as a real runnable agent
  - fix permission matching for wrapped commands like `snip git status*`
  - keep the new `eval/fixtures/` contract and add runnable build/fixer fixtures
  - tighten `ask` and `build` behavior around permission self-reporting and forbidden package-manager requests

## Phase Rollup

- Phase 1: useful but not presentation-ready; exposed role/config drift and the nested permission wrapper issue early
- Phase 2: partial success; `docs`, `quick-fixer`, and `android` gave credible signal, while `build` and `fixer` were fixture-blocked
- Phase 3: strongest phase overall; reviewer-style agents performed well with seeded diffs
- Phase 4: mixed; `researcher` and `deep-thinker` were strong, `learn` still failed as a role/config evaluation

## Agent Results

| Agent | Model | Tests | Avg Score | Pass Rate | Notes |
|---|---|---:|---:|---:|---|
| build | `openai/gpt-5.4` | 6 | 2.7 | 33% | Good at refusing fake app work and routing research; weak on forbidden `npm` handling and often affected by wrapper permissions |
| plan | `github-copilot/gemini-3.1-pro-preview` | 3 | 3.7 | 67% | Strong read-only planning when prompt is self-contained; nested `snip` permission issue hurts normal flow |
| ask | `openai/gpt-5.4-mini` | 2 | 0.5 | 0% | Role/config mismatch in smoke and canary output; claimed edit/delegation capabilities it should not have |
| learn | `openai/gpt-5.5-fast` intended | 2 | 1.0 | 0% | Not actually exposed as a runnable role; `opencode run --agent learn` falls back to `build` |
| deep-thinker | `openai/gpt-5.5` | 2 | 4.0 | 50% | High-quality security reasoning on self-contained prompts; repo-inspecting run still hit wrapper permission failure |
| fixer | `openai/gpt-5.3-codex-spark` | 2 | 1.5 | 0% | Safe narrow behavior signal exists, but real implementation eval is blocked until a seeded fixer fixture exists |
| reviewer | `github-copilot/gemini-3-flash-preview` | 1 | 5.0 | 100% | Strong merge-blocking review quality on seeded diff |
| security-reviewer | `openai/gpt-5.5` | 1 | 5.0 | 100% | Strong security findings with correct priorities and impact framing |
| researcher | `github-copilot/gemini-3.1-pro-preview` | 2 | 5.0 | 100% | Strong use of official docs and clear separation between facts and recommendations |
| docs | `github-copilot/claude-haiku-4.5` | 1 | 5.0 | 100% | Good minimal README update using only existing documented commands |
| android | `github-copilot/gemini-3-flash-preview` | 1 | 4.0 | 100% | Real signal once pointed at the external Android fixture; produced plausible Gradle/Kotlin findings without overreaching |
| quick-fixer | `openai/gpt-5.3-codex-spark` | 1 | 5.0 | 100% | Good tiny-scope suggestion behavior when given an explicit snippet |
| scout-review | `openai/gpt-5.3-codex-spark` | 1 | 5.0 | 100% | Good bounded second-opinion behavior on small diff |

## Keep

```txt
Models/configs to keep:
- reviewer on github-copilot/gemini-3-flash-preview
- security-reviewer on openai/gpt-5.5
- researcher on github-copilot/gemini-3.1-pro-preview
- docs on github-copilot/claude-haiku-4.5
- android on github-copilot/gemini-3-flash-preview, but always evaluate it against a real Android fixture repo
- quick-fixer/scout-review on openai/gpt-5.3-codex-spark for tiny-scope tasks
```

## Change

```txt
Models/configs to change:
- fix `learn` exposure so it is callable as its own role instead of falling back to `build`
- fix `ask` prompt/role behavior so it never claims edit or delegation powers it does not have
- make nested wrapped commands like `snip git status*` match the same allowed permission patterns as `git status*`
- add a runnable build fixture and a seeded fixer fixture under `eval/fixtures/`
- tighten build behavior so forbidden `npm` requests are refused immediately and explicitly
```

## Blockers

```txt
Issues that must be fixed before fully trusting this setup:
1. `learn` is not operational as a distinct role in active evaluation runs.
2. Nested `snip` wrapper behavior causes false permission failures in primary-agent evals.
3. Build/fixer execution phases are under-instrumented until proper fixtures exist.
4. Ask-agent self-description drift means the public-facing role explanation is currently unreliable.
```

## Next Eval Batch

```txt
Next tests to run:
1. Re-run Phase 1 after fixing `learn` exposure and wrapped-command permission matching.
2. Add a small real app/service fixture under eval/fixtures/build and re-run build implementation tests.
3. Add a tiny seeded type/lint/test failure under eval/fixtures/fixer and re-run fixer tests.
4. Add a dedicated self-contained planning fixture so plan can be scored without repo-inspection side effects.
5. Add a repeatable raw transcript capture method for subagent-based evals.
```

## References

- `eval/agents/results/phase-1/REPORT.md`
- `eval/agents/results/phase-2/REPORT.md`
- `eval/agents/results/phase-3/REPORT.md`
- `eval/agents/results/phase-4/REPORT.md`
