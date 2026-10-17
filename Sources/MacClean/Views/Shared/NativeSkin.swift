import SwiftUI
import AppKit
import MacCleanKit

enum NativeSkin {
    static let defaultsKey = "nativeMacSkin"
    static var isEnabled: Bool { UserDefaults.standard.object(forKey: defaultsKey) as? Bool ?? true }
}

/// Original, code-drawn glass instrument. No MacPaw artwork or branding.
struct CareOrb: View {
    let color: Color
    var symbol = "sparkles"
    var body: some View {
        ZStack {
            Circle().fill(color.opacity(0.25)).blur(radius: 25).padding(-12)
            Circle().fill(RadialGradient(colors: [.white.opacity(0.75), color.opacity(0.65), color.opacity(0.15), .black.opacity(0.5)], center: .topLeading, startRadius: 5, endRadius: 235))
            Circle().strokeBorder(LinearGradient(colors: [.white.opacity(0.85), color, .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
            Circle().fill(LinearGradient(colors: [.white.opacity(0.8), .white.opacity(0.12)], startPoint: .top, endPoint: .bottom))
                .frame(width: 112, height: 112)
                .shadow(color: .black.opacity(0.24), radius: 18, y: 14)
            Image(systemName: symbol).font(.system(size: 48, weight: .medium)).foregroundStyle(color)
            Ellipse().fill(.white.opacity(0.32)).frame(width: 118, height: 29).blur(radius: 8).rotationEffect(.degrees(-28)).offset(x: -36, y: -72)
        }
        .frame(width: 225, height: 225)
        .shadow(color: .black.opacity(0.22), radius: 22, y: 18)
        .accessibilityHidden(true)
    }
}

struct NativeScanWelcome: View {
    @Environment(AppState.self) private var appState
    @Environment(\.colorScheme) private var scheme
    let startScan: () -> Void
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 26) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(L10n.tr("智能养护", "Smart Care", "Умный уход"))
                            .font(.system(size: 34, weight: .bold))
                        Text(L10n.tr("让 Mac 焕然一新，给重要的事留出空间。", "A fresh start for your Mac. More room for what matters.", "Освободите место для самого важного."))
                            .font(.system(size: 14)).foregroundStyle(.secondary)
                    }
                    ViewThatFits(in: .horizontal) {
                        HStack(spacing: 30) {
                            CareOrb(color: .cyan)
                            introduction.frame(width: 260, alignment: .leading)
                        }
                        VStack(spacing: 24) {
                            CareOrb(color: .cyan)
                            introduction
                        }
                    }
                    .padding(30)
                    .frame(maxWidth: .infinity, minHeight: 300)
                    .background(.white.opacity(scheme == .dark ? 0.12 : 0.42), in: RoundedRectangle(cornerRadius: 28))
                    .overlay(RoundedRectangle(cornerRadius: 28).strokeBorder(.white.opacity(0.22)))

                    HStack(spacing: 18) {
                        tool(.systemJunk, "internaldrive.fill", L10n.tr("清理", "Cleanup", "Очистка"), .green)
                        tool(.malwareRemoval, "shield.lefthalf.filled", L10n.tr("防护", "Protection", "Защита"), .orange)
                        tool(.optimization, "bolt.fill", L10n.tr("性能", "Performance", "Скорость"), .purple)
                    }
                }
                .frame(maxWidth: 850)
                .padding(32)
                .frame(maxWidth: .infinity, minHeight: geometry.size.height, alignment: .center)
            }
        }
    }
    private var introduction: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(L10n.tr("轻盈，从一次扫描开始", "Meet your Mac at its best", "Ваш Mac в лучшей форме"))
                .font(.system(size: 24, weight: .semibold)).fixedSize(horizontal: false, vertical: true)
            Text(L10n.tr("查找垃圾文件，检查潜在威胁，了解性能状况。扫描完成后，由你选择处理哪些项目。", "Find clutter, check for potential threats, and review performance. Scan first, then choose what to clean.", "Найдите лишние файлы и проверьте безопасность. Решение об очистке за вами."))
                .font(.system(size: 14)).foregroundStyle(.secondary).lineSpacing(4).fixedSize(horizontal: false, vertical: true)
            ScanButton(title: L10n.tr("开始扫描", "Start Scan", "Сканировать"), action: startScan)
                .padding(.top, 6)
        }
    }
    private func tool(_ item: SidebarItem, _ icon: String, _ title: String, _ color: Color) -> some View {
        Button { appState.selectedSidebarItem = item } label: {
            HStack(spacing: 10) {
                Image(systemName: icon).font(.system(size: 17)).foregroundStyle(color)
                Text(title).font(.system(size: 13, weight: .medium)).foregroundStyle(.primary)
                Spacer(minLength: 0)
                Image(systemName: "chevron.right").font(.system(size: 10, weight: .semibold)).foregroundStyle(.secondary)
            }
            .padding(.vertical, 15).padding(.horizontal, 14)
            .background(.white.opacity(scheme == .dark ? 0.08 : 0.35), in: RoundedRectangle(cornerRadius: 14))
            .contentShape(RoundedRectangle(cornerRadius: 14))
        }.buttonStyle(.plain)
    }
}

struct CareSidebar: View {
    @Binding var selection: SidebarItem?
    @State private var showAllTools = false
    private let primary: [SidebarItem] = [.smartScan, .systemJunk, .malwareRemoval, .optimization, .uninstaller, .spaceLens]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 10) {
                Image(systemName: "sparkles").foregroundStyle(.cyan).font(.system(size: 20, weight: .semibold))
                Text("Mac Sai").font(.system(size: 20, weight: .bold)).foregroundStyle(.white)
            }.padding(.horizontal, 20).padding(.top, 20).padding(.bottom, 28)
            ScrollView {
                VStack(spacing: 7) {
                    ForEach(primary) { item in row(item) }
                    Divider().overlay(.white.opacity(0.1)).padding(.vertical, 12)
                    DisclosureGroup(isExpanded: $showAllTools) {
                        VStack(spacing: 4) {
                            ForEach(SidebarItem.allCases.filter { !primary.contains($0) && $0 != .settings }) { item in row(item) }
                        }.padding(.top, 10)
                    } label: {
                        Text(L10n.tr("全部工具", "All tools", "Все инструменты"))
                            .font(.system(size: 12, weight: .medium)).foregroundStyle(.white.opacity(0.65))
                    }.tint(.white.opacity(0.6)).padding(.horizontal, 10)
                }.padding(.horizontal, 10)
            }
            row(.settings).padding(10)
        }
        .background(LinearGradient(colors: [Color(red: 0.10, green: 0.12, blue: 0.22), Color(red: 0.07, green: 0.08, blue: 0.15)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea())
    }
    private func row(_ item: SidebarItem) -> some View {
        Button { selection = item } label: {
            HStack(spacing: 12) {
                Image(systemName: item.icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(item.theme.accentColor)
                    .frame(width: 30, height: 32)
                    .background(item.theme.accentColor.opacity(0.15), in: RoundedRectangle(cornerRadius: 9))
                Text(item == .smartScan ? L10n.tr("智能养护", "Smart Care", "Умный уход") : item.title)
                    .font(.system(size: 13, weight: selection == item ? .semibold : .medium))
                    .foregroundStyle(.white.opacity(selection == item ? 1 : 0.78))
                    .lineLimit(2)
                Spacer(minLength: 0)
            }.padding(.horizontal, 10).padding(.vertical, 8)
                .background(.white.opacity(selection == item ? 0.12 : 0), in: RoundedRectangle(cornerRadius: 12))
                .contentShape(RoundedRectangle(cornerRadius: 12))
        }.buttonStyle(.plain)
            .accessibilityAddTraits(selection == item ? [.isSelected] : [])
    }
}

struct CareModuleWelcome: View {
    let title: String
    let subtitle: String
    let theme: ModuleTheme
    let action: () -> Void
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                CareOrb(color: theme.accentColor, symbol: symbol)
                VStack(spacing: 10) {
                    Text(title).font(.system(size: 30, weight: .bold))
                    Text(subtitle).font(.system(size: 14)).foregroundStyle(.secondary)
                        .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                }
                ScanButton(title: L10n.tr("扫描", "Scan", "Сканировать"), theme: theme, action: action)
            }
            .frame(maxWidth: 480)
            .padding(32)
            .background(.white.opacity(scheme == .dark ? 0.10 : 0.35), in: RoundedRectangle(cornerRadius: 28))
            .overlay(RoundedRectangle(cornerRadius: 28).strokeBorder(.white.opacity(0.2)))
            .padding(30)
            .frame(maxWidth: .infinity)
        }
        .defaultScrollAnchor(.center)
    }
    private var symbol: String {
        switch theme {
        case .cleanup: "sparkles"
        case .protection: "shield.lefthalf.filled"
        case .performance: "bolt.fill"
        case .applications: "square.stack.3d.up.fill"
        case .files: "folder.fill"
        case .smartScan, .settings: "sparkles"
        }
    }
}

extension Color {
    init(careHex: UInt32) {
        self.init(red: Double((careHex >> 16) & 255) / 255,
                  green: Double((careHex >> 8) & 255) / 255,
                  blue: Double(careHex & 255) / 255)
    }
}
