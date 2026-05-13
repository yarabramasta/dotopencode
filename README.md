# OpenCode Dotfiles

Personal OpenCode dotfiles for global config, agent routing, and workspace rules.

## What Is Included

- `config/opencode.jsonc`: OpenCode config with model, agent, and permission settings.
- `config/AGENTS.md`: Global OpenCode agent rules.
- `install.sh`: Safe installer that symlinks files from `config/` into `~/.config/opencode`.
- `tests/agents/`: Archived evaluation playbook and prompts from the previous agent orchestration testing setup.

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
