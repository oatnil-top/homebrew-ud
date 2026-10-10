# Homebrew Tap for UnDercontrol

The official Homebrew tap for the UnDercontrol CLI (`ud`) and the self-hosted
server (`ud-server`).

## Installation

```bash
brew tap oatnil-top/ud
brew trust oatnil-top/ud   # Homebrew >= 6 only; older versions have no `trust`
brew install ud
```

Homebrew 6 refuses to load a formula from a third-party tap until you trust it,
and says so with a hard error rather than a prompt. Linuxbrew and Homebrew 4/5
do not have the `trust` subcommand — skip that line there.

## Self-hosted server

```bash
brew install ud-server
brew services start ud-server     # runs in the background, starts again at login
```

Then open http://localhost:8080. Configuration is in `$(brew --prefix)/etc/ud-server/.env`,
data in `$(brew --prefix)/var/ud-server`, the log in `$(brew --prefix)/var/log/ud-server.log`.
Upgrades replace only the binary; configuration and data stay. `JWT_SECRET` is
generated at install. The server listens on all network interfaces; set `HOST_DOMAIN`
in the `.env` to the URL other machines use if you serve them.

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

`Formula/ud.rb` and `Formula/ud-server.rb` are generated — do not hand-edit
them. After publishing a release (CLI to R2, server to npm), run:

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
