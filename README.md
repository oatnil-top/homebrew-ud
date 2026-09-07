# Homebrew Tap for UnDercontrol CLI

The official Homebrew tap for the UnDercontrol CLI (`ud`).

## Installation

```bash
brew tap oatnil-top/ud
brew install ud
```

## Upgrade

```bash
brew update
brew upgrade ud
```

## Uninstall

```bash
brew uninstall ud
brew untap oatnil-top/ud
```

## Other install channels

npm works too, and ships the same binaries:

```bash
npm install -g @oatnil/ud
```

## For maintainers

`Formula/ud.rb` is generated — do not hand-edit it. After publishing a CLI
release to R2, run:

```bash
./update-formula.sh <version>          # verify + write
./update-formula.sh <version> --check  # verify only, write nothing
```

The script downloads every artifact from the URL the formula will point at and
pins the sha256 of the bytes it actually received. If an artifact is missing it
refuses to write the formula, which is the failure this tap already had once:
it sat pinned at 0.49.0, a version whose objects are not in the bucket, so every
URL in the formula was a live 404.

Note that the release uploader prunes R2 to the newest 10 CLI versions, so the
formula must track a recent release.

## About UnDercontrol

UnDercontrol is a task and expense management application. The `ud` CLI provides
terminal access to your tasks with a TUI interface.

## Links

- [UnDercontrol](https://ud.oatnil.com)
