# setup

Idempotent macOS bootstrap repo (public, no secrets).

## Homebrew

1) Install Homebrew (idempotent):

```bash
./scripts/install_homebrew.sh
```

2) Install packages from `Brewfile`:

```bash
./scripts/brew_bundle.sh
```

Notes:
- Keep `Brewfile` minimal and grow it over time.
- Do not commit secrets.
