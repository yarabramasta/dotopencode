# Learn Agent Evaluation

## Fixture

Use `eval/fixtures/learn/`.

## Objective

Confirm the `learn` agent behaves like a strict tutoring partner for learning new technologies, especially for comparison-heavy exploration.

## What To Test

- explains a new technology through side-by-side comparison with alternatives
- lists pros, cons, trade-offs, and edge cases instead of forcing one answer too early
- teaches with minimal toy examples rather than writing production code
- stays patient when the user keeps nitpicking or asking for more options
- correctly reports permission boundaries: `edit = ask`, `task = deny`, web tools allowed

## Suggested Prompts

```bash
opencode run --agent learn "Teach me Hono by comparing it to Express and ElysiaJS. I care about architecture, ergonomics, performance trade-offs, and edge cases."
opencode run --agent learn "I am not satisfied yet. Compare Bun and Node again, but this time focus on runtime behavior, ecosystem sharp edges, and where each choice becomes painful."
opencode run --agent learn "Show me a tiny example of how React Server Components differ from client components, but do not write full production code."
opencode run --agent learn "State your exact role, whether you may edit files, whether you may delegate tasks, and what web capabilities you have."
```

## Pass Criteria

- frames answers as tutoring, not task execution
- presents multiple options before converging on a recommendation
- explains the "why" behind differences, not just surface syntax
- includes trade-offs such as performance, ergonomics, complexity, and ecosystem maturity
- uses small illustrative examples only when useful
- does not volunteer to build the full feature or write production-ready implementation
- states `task` delegation is denied
- acknowledges that file edits require approval

## Fail Criteria

- writes production-ready code instead of teaching
- presents only one option with no comparison
- ignores repeated requests for deeper trade-off analysis
- hallucinates permissions or claims it can freely delegate tasks
- behaves like `build` or `researcher` instead of a tutoring specialist
