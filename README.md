# OpenCode Dotfiles

Personal OpenCode dotfiles for running a structured multi-agent setup with opinionated model routing, permission boundaries, and workspace rules.

This repository is the source of truth for my local OpenCode configuration. It keeps the agent system reproducible, reviewable, and easy to reinstall on a new machine.

## Project Goals

- keep OpenCode config under version control
- define clear roles for primary agents and subagents
- enforce practical permission boundaries for edit, bash, and delegation
- preserve shared workspace rules in a single place
- keep an eval workspace for validating whether agents still match their intended roles

## What Is Included

- `config/opencode.jsonc`: Main OpenCode config with default model selection, agent definitions, permissions, and tool behavior.
- `config/AGENTS.md`: Global workspace rules that shape how agents behave across repos.
- `install.sh`: Safe installer that symlinks config files into `~/.config/opencode`.
- `eval/agents/`: Evaluation playbook, role expectations, and prompt suites for testing agent behavior.

## Agent Setup

The config is organized around a few primary agents and a set of narrower specialist subagents.

- Primary agents cover day-to-day coding, planning, lightweight chat, deep reasoning, and technology learning.
- Specialist agents cover documentation, reviews, security review, research, Android work, and small mechanical fixes.
- Permissions are intentionally uneven. Some agents can edit, some are read-only, and some are allowed to browse or run only a narrow set of commands.

This repo currently includes a `learn` agent focused on tutoring and technology exploration. It is tuned for comparison-heavy learning: weighing trade-offs, explaining internals, and helping a user explore options without jumping straight to production implementation.

## Eval Workspace

The `eval/agents/` folder exists to test whether the configured agents still behave the way the config says they should.

It includes:

- shared role and safety expectations
- a playbook for evaluating model-role fit
- targeted prompts for smoke tests, routing tests, and specialist-agent checks

This is useful when changing models, rewriting agent descriptions, or adding new agents such as `learn`.

## Install

From a local clone:

```bash
./install.sh
```

From GitHub after publishing this repo:

```bash
curl -fsSL https://raw.githubusercontent.com/yarabramasta/dotopencode/main/install.sh | bash
```

## Safety

The installer only links top-level files inside `config/` into `~/.config/opencode`.

Existing files are not overwritten. By default, conflicts are moved into a timestamped backup directory:

```txt
~/.config/opencode-backups/YYYYmmdd-HHMMSS/
```

Use `--dry-run` to preview changes:

```bash
./install.sh --dry-run
```

Use `--no-backup` if you prefer the installer to abort when a target file already exists:

```bash
./install.sh --no-backup
```

## Custom Paths

Install into a custom OpenCode config directory:

```bash
./install.sh --target ~/.config/opencode
```

For curl installs, the repo is cloned to `~/.local/share/dotopencode` before symlinking. Override that location with:

```bash
DOTOPENCODE_HOME=~/.local/share/my-opencode-dotfiles ./install.sh
```

## Files Linked

The default install creates these symlinks:

```txt
~/.config/opencode/AGENTS.md -> <repo>/config/AGENTS.md
~/.config/opencode/opencode.jsonc -> <repo>/config/opencode.jsonc
```

## Typical Workflow

1. Update agent config or workspace rules in this repo.
2. Review the changes in git.
3. Reinstall or relink with `./install.sh`.
4. Run prompts from `eval/agents/` when changing agent roles, permissions, or model assignments.

## Why This Repo Exists

OpenCode configuration becomes hard to reason about when prompts, permissions, and model choices evolve informally.

This repo keeps those decisions explicit:

- which agent should handle what kind of task
- which models are assigned to which roles
- what an agent is allowed to edit or execute
- how to re-check that the setup still behaves as intended
