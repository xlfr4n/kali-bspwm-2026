# Architecture

The project has five layers:

- `install.sh`: OS/package/session integration.
- `config/`: user-facing X11/BSPWM configuration.
- `scripts/`: runtime helpers installed into `~/.local/bin`.
- `themes/`: visual theme metadata.
- `docs/`: operational notes.

The installer is deliberately conservative: package manager first, existing display/audio stack preserved, timestamped backups before replacement, and optional Python tooling isolated with pipx.
