# AGENTS.md

This repository is intended to be safe to run repeatedly on macOS to bootstrap a new machine (idempotent setup).

## Repo rules (must follow)

- **No secrets in git.** Never commit tokens, PATs, passwords, private keys, `.env` with secrets, SSH keys, etc.
- **PR-only changes.** Do not push to `main`. All changes happen on a branch and land via a Pull Request.
- **Auto-merge allowed (after approval).** If required reviews are satisfied and the PR is mergeable per branch rules, the agent may merge (typically squash), unless the owner says otherwise on that PR.
- **Idempotent by default.** Scripts should be safe to run multiple times.
- **Prefer small PRs.** Keep changes reviewable; explain what you changed and how to test.
- **No spam.** Avoid repeated "intent check" comments. If you already asked questions and there’s no owner reply yet, wait.

## What an agent may do

- Create branches, commit changes, push branches.
- Open Pull Requests (draft is fine) describing changes and test steps.
- Add/update docs and scripts to improve reproducibility.

## What an agent must not do

- Merge PRs **unless they meet the repo rules and are approved** (auto-merge is allowed once approval requirements are satisfied).
- Introduce secret handling that stores secrets in the repo.
- Run destructive commands (e.g., deleting user data) without explicit confirmation.

## Conventions

- Branch naming: `feature/...`, `chore/...`, `fix/...`
- Commit style: concise, imperative (e.g., `chore: add bootstrap skeleton`)
- Include a **Test plan** in PR descriptions.

## Issue intake (owner requests)

When the owner opens an Issue (feature request / change request), the agent should **first validate intent** before implementing.

**Step 1 — restate the goal:**
- Summarize what you think the owner wants in 1–3 bullets.

**Step 2 — confirm scope & constraints:**
- What is in-scope / out-of-scope for this change?
- Any idempotency concerns?
- Any security/privacy concerns (secrets, data deletion, etc.)?

**Step 3 — propose an approach:**
- Outline a minimal implementation plan.
- Call out alternatives and trade-offs if relevant.

**Step 4 — get a “go” signal:**
- Ask for confirmation (a short “yes/ship it” is enough) before doing non-trivial work.

Once confirmed, implement on a branch and open a PR linking the Issue.

## macOS bootstrap principles

- Detect before changing (e.g., check if Homebrew exists before installing).
- Prefer declarative config where possible (e.g., `Brewfile`).
- Print clear output and next steps.

