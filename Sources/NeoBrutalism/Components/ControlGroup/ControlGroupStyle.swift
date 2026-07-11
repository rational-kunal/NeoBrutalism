import SwiftUI

/// A neobrutalism control group style: the controls sit in one joined bar with rounded
/// ends. Each section has its own box — only the first and last round their outer corners
/// so the middle stays square — and darkens while pressed.
///
/// Sections use the theme's `main` color, or a `.backgroundStyle(_:)` set on the group:
///
/// ```swift
/// ControlGroup {
///     Button("Bold") {}
///     Button("Italic") {}
/// }
/// .controlGroupStyle(.neoBrutalism)
/// .backgroundStyle(.orange) // optional per-instance fill
/// ```
///
/// - Note: Per-section corners need `Group(subviews:)` (iOS 18+); on iOS 17 every section
///   is fully rounded.
public struct NBControlGroupStyle: ControlGroupStyle {
    @Environment(\.nbTheme) private var theme

    public func makeBody(configuration: Configuration) -> some View {
        sections(for: configuration)
            .buttonStyle(NBControlGroupSectionStyle())
            .fixedSize(horizontal: false, vertical: true)
    }

    /// Enumerates the sections to hand each one its corners through the environment,
    /// which — unlike a button style — survives the `Subview` boundary. Adjacent boxes
    /// overlap by one border width so their shared edges merge into a single line.
    @ViewBuilder
    private func sections(for configuration: Configuration) -> some View {
        if #available(iOS 18.0, *) {
            Group(subviews: configuration.content) { subviews in
                HStack(spacing: -theme.borderWidth) {
                    ForEach(subviews.indices, id: \.self) { index in
                        subviews[index]
                            .environment(\.nbSectionCorners, corners(index, of: subviews.count))
                    }
                }
            }
        } else {
            HStack(spacing: -theme.borderWidth) { configuration.content }
        }
    }

    /// Only the outer ends of the bar round: first → `.left`, last → `.right`, a lone
    /// section → `.all`, everything in between square.
    ///
    /// Internal (not `private`) so `Tests/NeoBrutalismTests/Unit/CornerSetTests.swift` can
    /// exercise it via `@testable import`.
    func corners(_ index: Int, of count: Int) -> NBCornerSet {
        guard count > 1 else { return .all }
        if index == 0 { return .left }
        if index == count - 1 { return .right }
        return []
    }
}

public extension ControlGroupStyle where Self == NBControlGroupStyle {
    /// A neobrutalism control group style. Override the section fill with `.backgroundStyle(_:)`.
    static var neoBrutalism: NBControlGroupStyle { .init() }
}

// MARK: - Section

/// A single section's appearance. One instance per button, so `isPressed` is tracked
/// independently and only the pressed section darkens. Corners come from the environment,
/// set by the group per position.
private struct NBControlGroupSectionStyle: ButtonStyle {
    @Environment(\.nbTheme) private var theme
    @Environment(\.backgroundStyle) private var backgroundStyle
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.nbSectionCorners) private var corners

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(theme.mainText)
            .padding(theme.smpadding)
            .background {
                Rectangle().fill(backgroundStyle ?? AnyShapeStyle(theme.main))
                if configuration.isPressed {
                    theme.border.opacity(0.15)
                }
            }
            .nbBox(roundedCorners: corners)
            .animation(reduceMotion ? .none : .interactiveSpring(), value: configuration.isPressed)
    }
}

private struct NBSectionCornersKey: EnvironmentKey {
    static let defaultValue: NBCornerSet = .all
}

private extension EnvironmentValues {
    var nbSectionCorners: NBCornerSet {
        get { self[NBSectionCornersKey.self] }
        set { self[NBSectionCornersKey.self] = newValue }
    }
}

// MARK: - Preview

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(alignment: .leading, spacing: 20) {
        ControlGroup {
            Button("Bold") {}
            Button("Italic") {}
            Button("Underline") {}
        }
        .controlGroupStyle(.neoBrutalism)

        ControlGroup {
            Button("Bold") {}
            Button("Italic") {}
            Button("Underline") {}
        }
        .controlGroupStyle(.neoBrutalism)
        .backgroundStyle(.orange)
    }
    .padding()
}
