# Webskiff Homebrew tap

Source-building Homebrew recipes for [Webskiff](https://github.com/engineersamuel/webskiff).

The first recipe is being tested before publication. It targets macOS on Apple
Silicon. There is no Intel Mac or Linux Homebrew recipe.

Webskiff builds from pinned source with Homebrew Rust. The recipe downloads a
checksum-pinned, prebuilt [Zebkit/Chromium engine](https://github.com/ikey4u/zebkit).
This is not a source build of Chromium. No paid Apple Developer membership or
Webskiff signing certificate is required.

Webskiff is an experimental browser, not an approved company browser. Video,
corporate sign-in, and assistive technology support remain unverified. See the
application's README for current limits and terminal requirements.

## Maintenance

Generate recipes with the application's `scripts/release.py brew-source` command.
Pin a full source commit and SHA-256 values for both source and engine.
Test a candidate branch with this repository's macOS workflow before publication.
After publication, dispatch that workflow with `public-tap=true` to test the real
remote tap in a separate fresh runner.

Do not publish bottles or unsigned Webskiff binary archives through this tap.
Keep upstream license and attribution files inside the engine.
