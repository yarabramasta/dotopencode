#!/usr/bin/env bash
set -euo pipefail

repo_url="${DOTOPENCODE_REPO:-https://github.com/yarabramasta/dotopencode.git}"
install_dir="${DOTOPENCODE_HOME:-$HOME/.local/share/dotopencode}"
target_dir="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
backup_root="${DOTOPENCODE_BACKUP_DIR:-$HOME/.config/opencode-backups}"
backup_enabled=1
dry_run=0

usage() {
  cat <<'USAGE'
Usage: install.sh [options]

Safely symlink files from this repo's config/ directory into ~/.config/opencode.

Options:
  --repo URL          Git repo used when the script is run through curl
  --home DIR          Local clone path for curl installs
  --target DIR        OpenCode config target directory
  --backup-dir DIR    Directory where replaced files are backed up
  --no-backup         Abort instead of backing up existing target files
  --dry-run           Print actions without changing files
  -h, --help          Show this help

Environment variables:
  DOTOPENCODE_REPO, DOTOPENCODE_HOME, OPENCODE_CONFIG_DIR, DOTOPENCODE_BACKUP_DIR
USAGE
}

log() {
  printf '%s\n' "$*"
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

run() {
  if [ "$dry_run" -eq 1 ]; then
    printf 'dry-run:'
    printf ' %q' "$@"
    printf '\n'
    return 0
  fi

  "$@"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --repo)
      [ "$#" -ge 2 ] || die "--repo requires a value"
      repo_url="$2"
      shift 2
      ;;
    --home)
      [ "$#" -ge 2 ] || die "--home requires a value"
      install_dir="$2"
      shift 2
      ;;
    --target)
      [ "$#" -ge 2 ] || die "--target requires a value"
      target_dir="$2"
      shift 2
      ;;
    --backup-dir)
      [ "$#" -ge 2 ] || die "--backup-dir requires a value"
      backup_root="$2"
      shift 2
      ;;
    --no-backup)
      backup_enabled=0
      shift
      ;;
    --dry-run)
      dry_run=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "unknown option: $1"
      ;;
  esac
done

script_dir=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
fi

if [ -n "$script_dir" ] && [ -d "$script_dir/config" ]; then
  repo_dir="$script_dir"
else
  command -v git >/dev/null 2>&1 || die "git is required for curl installs"

  if [ -d "$install_dir/.git" ]; then
    log "Updating $install_dir"
    run git -C "$install_dir" pull --ff-only
  elif [ -e "$install_dir" ]; then
    die "$install_dir exists but is not a git checkout"
  else
    log "Cloning $repo_url into $install_dir"
    run mkdir -p "$(dirname -- "$install_dir")"
    run git clone "$repo_url" "$install_dir"
  fi

  repo_dir="$install_dir"
fi

config_dir="$repo_dir/config"
[ -d "$config_dir" ] || die "missing config directory: $config_dir"

run mkdir -p "$target_dir"
timestamp="$(date +%Y%m%d-%H%M%S)"
backup_dir="$backup_root/$timestamp"

shopt -s nullglob dotglob
sources=("$config_dir"/*)
shopt -u nullglob dotglob

[ "${#sources[@]}" -gt 0 ] || die "no files found in $config_dir"

for source in "${sources[@]}"; do
  name="$(basename -- "$source")"
  target="$target_dir/$name"

  if [ -L "$target" ] && [ "$target" -ef "$source" ]; then
    log "Already linked: $target"
    continue
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ "$backup_enabled" -ne 1 ]; then
      die "$target exists; rerun without --no-backup or move it manually"
    fi

    log "Backing up $target to $backup_dir/$name"
    run mkdir -p "$backup_dir"
    run mv "$target" "$backup_dir/$name"
  fi

  log "Linking $target -> $source"
  run ln -s "$source" "$target"
done

log "OpenCode dotfiles installed. Target: $target_dir"
if [ -d "$backup_dir" ]; then
  log "Backups: $backup_dir"
fi
