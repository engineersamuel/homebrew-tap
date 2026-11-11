# Webskiff Homebrew tap

Source-building Homebrew recipes for [Webskiff](https://github.com/engineersamuel/webskiff).

## Install: macOS on Apple Silicon

```sh
brew install engineersamuel/tap/webskiff
webskiff https://example.com
```

The full install command adds this tap automatically. If you have already run
`brew tap engineersamuel/tap`, `brew install webskiff` also works. This formula is
not in Homebrew's main repository. There is no Intel Mac or Linux Homebrew recipe.

Use a Kitty-graphics-capable terminal for page images; Herdr is the primary
target. Press `?` or `F1` for keyboard help. Use `/` to find page text, then Enter
and `n`/`N` to move between matches.

Webskiff builds from pinned source with Homebrew Rust. The recipe downloads a
checksum-pinned, prebuilt [Zebkit/Chromium engine](https://github.com/ikey4u/zebkit).
This is not a source build of Chromium. No paid Apple Developer membership or
Webskiff signing certificate is required.

```sh
brew test engineersamuel/tap/webskiff
webskiff --selftest
```

`brew test` checks the CLI. Run the engine self-test directly: Chromium's sandbox
cannot nest inside Homebrew's test sandbox. Do not disable Chromium's sandbox.

Homebrew manages the program and engine together. Upgrade or remove with:

```sh
brew upgrade engineersamuel/tap/webskiff
brew uninstall engineersamuel/tap/webskiff
```

Uninstall leaves `~/.config/webskiff/config.toml` and `~/.cache/zweb/profile`
untouched. The example configuration and Webskiff license/credits are under
`$(brew --prefix)/share/webskiff`.

Webskiff is an experimental browser, not an approved company browser. Video,
corporate sign-in, and assistive technology support remain unverified. See the
application's README for current limits and terminal requirements.

## Maintenance

The [candidate check](https://github.com/engineersamuel/homebrew-tap/actions/runs/42940350241)
passed on a fresh macOS 15.8.2 ARM64 runner: source installation, style/strict audit,
CLI and engine checks, three real-browser keyboard modes, and uninstall with user
files preserved. Hosted checks do not prove physical-terminal or video behavior.

Generate recipes with the application's `scripts/release.py brew-source` command.
Pin a full source commit and SHA-256 values for both source and engine.
Test a candidate branch with this repository's macOS workflow before publication.
After publication, dispatch that workflow with `public-tap=true` to test the real
remote tap in a separate fresh runner.

Do not publish bottles or unsigned Webskiff binary archives through this tap.
Keep upstream license and attribution files inside the engine.
The tap and Webskiff's own code are MIT-licensed. Zebkit and Chromium retain
their upstream licenses.
