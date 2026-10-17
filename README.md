# Mac Sai Themes — Native & Glass Care

**A personal macOS interface redesign for the open-source Mac Sai app.**

This repository shares my **appearance/theme customization**, not authorship of the original cleaner. It is based on [iliyami/MacSai](https://github.com/iliyami/MacSai), upstream commit `36ea6bd`, version **1.25.3**. The upstream [BSD-3-Clause license](LICENSE) and credits are retained.

[Download source and local test build](https://github.com/yuhengz117-pixel/MacSai-Themes/releases/latest)

## What changed

- A macOS Native appearance with semantic colors, system typography, and a quiet split layout.
- A later Glass Care iteration with a compact dark sidebar, per-module backgrounds, and SwiftUI-drawn glass-orb illustrations.
- A working appearance switch in **Settings → Appearance → Interface style**.
- Shared scan welcome panels, navigation shortcuts, and consistent module styling.
- Separate local app identity and preferences so the official app is not replaced.

The final bundled source contains **Glass Care as the evolved native-style implementation**, plus the selectable original gradients. The earlier Native edition is documented in `NATIVE-SKIN.md`; it is not a separate additional style switch in the final build.

The orb artwork is drawn in SwiftUI. No CleanMyMac artwork or branding is bundled. The app's scanning, cleanup, security-sensitive operations and core product functionality originate upstream.

## Files

| File | Purpose |
| --- | --- |
| `NativeSkin.swift` | Main code-drawn appearance components |
| `theme-changes.patch` | Complete local delta against upstream commit `36ea6bd` |
| `NATIVE-SKIN.md` | First native-style design and earlier validation notes |
| `GLASS-CARE.md` | Glass Care design iteration |
| `MacSai-Theme-source.zip` | Complete modified source tree, including upstream code/license |

The full source archive is provided so the theme can be rebuilt without manually assembling review files. Detailed source code remains organized inside the archive.

## Rebuild

Download and extract the source archive, then run inside its root:

```sh
BUILD_ARCHS="--arch arm64" bash scripts/build-dmg.sh --app-only
```

Requires the relevant Swift/Xcode macOS build tools. The source package uses GRDB.swift, declared in Package.swift. Consult `README.upstream.md` in the archive for original project requirements and functionality.

Alternatively, obtain upstream commit `36ea6bd`, then apply this repository's patch from the upstream checkout:

```sh
git apply /path/to/theme-changes.patch
```

The patch was checked against that exact upstream baseline before publication.

## Local build and scope

A pre-existing Apple Silicon Glass Care build is attached to Releases for testing. The app is called **Mac Sai Native.app**, and its **macOS Native** style preference activates the Glass Care appearance in the final iteration.

This local build is **ad-hoc signed, not Apple-notarized**, and is not an official upstream or MacPaw release. Do not confuse the original project's notarization statements with this customization. If macOS blocks a downloaded build, rebuild from source; do not disable security protections.

No cleanup or maintenance operation was run as part of publishing. Existing design notes record earlier build, visual, preference-switching and signature checks; they are not claims of a fresh full backend regression test.

The local build retains upstream cleanup confirmations. It does not grant macOS permissions on your behalf. Personal preferences, caches, logs and user files are not included in these source archives.

## Credit and license

- Original application: [Mac Sai](https://github.com/iliyami/MacSai), Mac Sai Contributors.
- Local appearance customization and iteration: [yuhengz117-pixel](https://github.com/yuhengz117-pixel), with AI-assisted implementation.
- License: [BSD-3-Clause](LICENSE), including the retained upstream notice.

## 中文简介

这是我为开源 Mac Sai 做的软件主题改版：先做 macOS Native，再迭代为 Glass Care。我的贡献主要是界面、视觉组件、布局和样式切换；清理软件本体来自上游 Mac Sai。

仓库提供主题源码、完整改动补丁和可重建源码包。Releases 中的现成测试版为本机签名的 Apple Silicon 构建，未经过 Apple 公证。
