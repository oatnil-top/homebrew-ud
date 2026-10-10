# Homebrew Tap for UnDercontrol

The official Homebrew tap for the UnDercontrol CLI (`ud`), the self-hosted
server (`ud-server`) and the macOS desktop app (cask `undercontrol`).

## Installation

```bash
brew tap oatnil-top/ud
# Homebrew >= 6 only; older versions have no `trust`
brew trust oatnil-top/ud
brew install ud
```

Homebrew 6 refuses to load a formula from a third-party tap until you trust it,
and says so with a hard error rather than a prompt. Linuxbrew and Homebrew 4/5
do not have the `trust` subcommand — skip that line there.

## Self-hosted server

```bash
brew install ud-server
# runs in the background, starts again at login
brew services start ud-server
```

Then open http://localhost:8080. Configuration is in `$(brew --prefix)/etc/ud-server/.env`,
data in `$(brew --prefix)/var/ud-server`, the log in `$(brew --prefix)/var/log/ud-server.log`.
Upgrades replace only the binary; configuration and data stay. `JWT_SECRET` is
generated at install. The server listens on all network interfaces; set `HOST_DOMAIN`
in the `.env` to the URL other machines use if you serve them.

## Desktop app (macOS)

```bash
brew install --cask undercontrol
```

Installs `UnDercontrol.app` (Apple Silicon or Intel, picked for your Mac) from the
same notarized DMGs as https://udctl.com/download. Requires macOS 12 or later.

The app does not update itself: its "Check for Updates" only tells you a newer
version exists and opens the download page. If you installed with brew, upgrade
with brew (below). Installing a DMG by hand over a brew-installed app works, but
leaves brew's record one version behind until the next `brew upgrade`.

The cask does not put `ud` on your PATH; that is the `ud` formula's job. The
app's own "install the CLI" action symlinks `/usr/local/bin/ud`, which on an
Intel Mac is also where the formula links `ud` -- use one or the other.

## Upgrade

```bash
brew update
brew upgrade ud
brew upgrade --cask undercontrol
```

## Uninstall

```bash
brew uninstall ud
# removes the app, keeps your data
brew uninstall --cask undercontrol
# ALSO DELETES your local data (unless you moved it)
brew uninstall --cask --zap undercontrol
brew untap oatnil-top/ud
```

## Other install channels

npm works too, and ships the same binaries:

```bash
npm install -g @oatnil/ud
```

## For maintainers

`Formula/ud.rb`, `Formula/ud-server.rb` and `Casks/undercontrol.rb` are
generated — do not hand-edit them. After publishing a release (CLI to R2,
server to npm, desktop DMGs to R2), run:

```bash
# verify + write
./update-formula.sh <version>
# verify only, write nothing
./update-formula.sh <version> --check
```

The script downloads every artifact from the URL the formula will point at and
pins the sha256 of the bytes it actually received. If an artifact is missing it
refuses to write the formula, which is the failure this tap already had once:
it sat pinned at 0.49.0, a version whose objects are not in the bucket, so every
URL in the formula was a live 404.

Note that the release uploaders prune R2 to the newest 10 CLI versions and the
newest 2 desktop versions, so the tap must track a recent release: a cask two
releases behind is a 404.

## About UnDercontrol

UnDercontrol is a task and expense management application. The `ud` CLI provides
terminal access to your tasks with a TUI interface.

## Links

- [UnDercontrol](https://ud.oatnil.com)
