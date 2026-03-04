# AGENTS.md

This repository is intended to be safe to run repeatedly on macOS to bootstrap a new machine (idempotent setup).

## Repo rules (must follow)

- **No secrets in git.** Never commit tokens, PATs, passwords, private keys, `.env` with secrets, SSH keys, etc.
- **PR-only changes.** Do not push to `main`. All changes happen on a branch and land via a Pull Request.
- **Idempotent by default.** Scripts should be safe to run multiple times.
- **Prefer small PRs.** Keep changes reviewable; explain what you changed and how to test.

## What an agent may do

- Create branches, commit changes, push branches.
- Open Pull Requests (draft is fine) describing changes and test steps.
- Add/update docs and scripts to improve reproducibility.

## What an agent must not do

- Merge PRs (unless the owner explicitly asks).
- Introduce secret handling that stores secrets in the repo.
- Run destructive commands (e.g., deleting user data) without explicit confirmation.

## Conventions

- Branch naming: `feature/...`, `chore/...`, `fix/...`
- Commit style: concise, imperative (e.g., `chore: add bootstrap skeleton`)
- Include a **Test plan** in PR descriptions.

## macOS bootstrap principles

- Detect before changing (e.g., check if Homebrew exists before installing).
- Prefer declarative config where possible (e.g., `Brewfile`).
- Print clear output and next steps.

