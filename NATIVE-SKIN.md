# Mac Sai Native

Local macOS appearance edition based on upstream Mac Sai v1.25.3.

## Use

Open **Mac Sai Native.app**. Go to Settings → Appearance → Interface style.
Choose **macOS Native** or **Original gradients**. The choice persists and
applies immediately. Light, Dark, and System are available separately.
Native is the default style; System is the default appearance.

## Design

- Semantic AppKit colors adapt to light, dark, and increased contrast.
- System type, hierarchical SF Symbols, standard push buttons and focus behavior.
- Material reserved for the sidebar; content uses an opaque, quiet surface.
- Smart Scan has three working navigation shortcuts; no fabricated statistics.
- Scan and cleanup logic and confirmations remain upstream behavior.

## Local edition

The app has its own name, bundle ID, preferences, cache database, log folder,
and URL scheme. The official app is not replaced. Automatic update checks
and the menu bar helper default to off for this local build. Installing an
upstream release does not add this appearance to the official app.

This is an ad-hoc signed local build, not an Apple-notarized upstream release.
Some modules may need Full Disk Access granted separately by the user. No
security permissions are granted by this project. The upstream privileged
helper's signing requirements are unchanged.

## Rebuild

```sh
BUILD_ARCHS="--arch arm64" bash scripts/build-dmg.sh --app-only
```

Source remains under the upstream BSD-3-Clause license (see LICENSE).

## Design review

| Apple principle | Result in this edition |
| --- | --- |
| Purpose | Scan is the main action; space, apps, and disk have direct entries. |
| Agency | Original appearance remains selectable; cleanup confirmations are retained. |
| Responsibility | No new scan destinations or deletion capabilities. |
| Familiarity | Native split navigation, system colors, SF Symbols, grouped settings. |
| Flexibility | System/light/dark appearance and resizable, scrolling content. |
| Simplicity | One accent and a quiet surface replace full-pane color gradients. |
| Craft | Shared scan controls and module colors use the same visual rules. |
| Delight | Restrained material and hierarchy; no new decorative animation. |

## Validation on this Mac

- Apple Silicon release compilation completed successfully.
- Installed app passed `codesign --verify --deep --strict`.
- Inspected actual light and dark windows; verified original/native switching.
- Verified the home shortcut navigates to System Junk without starting a scan.
- Relaunched the final build and confirmed native/system preferences persist.
- Confirmed Settings no longer reports an unregister error with the widget off.
- No cleanup operation was executed; no claim of full backend regression testing.
