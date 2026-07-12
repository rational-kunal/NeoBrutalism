import SwiftUI

/// A root view modifier that injects the NeoBrutalism theme and applies all
/// default component styles to the view tree.
///
/// Apply this once at the root of your view hierarchy to get the full
/// neobrutalism look on every supported SwiftUI control.
struct NBRootModifier: ViewModifier {
    let theme: NBTheme
    let applyBackground: Bool

    func body(content: Content) -> some View {
        let styled = content
            .buttonStyle(.neoBrutalism())
            .toggleStyle(.neoBrutalismCheckbox)
            .textFieldStyle(.neoBrutalism)
            .progressViewStyle(.neoBrutalism)
            .disclosureGroupStyle(.neoBrutalism)
            .controlGroupStyle(.neoBrutalism)
            .groupBoxStyle(.neoBrutalism())
            .environment(\.nbTheme, theme)

        if applyBackground {
            styled
                .background(theme.background.ignoresSafeArea())
        } else {
            styled
        }
    }
}

public extension View {
    /// Applies the default NeoBrutalism theme and all component styles to the view tree.
    ///
    /// Use this modifier at the root of your view hierarchy to automatically style
    /// every supported SwiftUI control (Button, Toggle, TextField, ProgressView,
    /// DisclosureGroup, ControlGroup, GroupBox) with the neobrutalism look.
    ///
    /// ```swift
    /// var body: some View {
    ///     NavigationStack {
    ///         MyContent()
    ///     }
    ///     .neoBrutalism()
    /// }
    /// ```
    func neoBrutalism() -> some View {
        modifier(NBRootModifier(theme: .default, applyBackground: false))
    }

    /// Applies a custom NeoBrutalism theme and all component styles to the view tree.
    ///
    /// - Parameter theme: The ``NBTheme`` to inject into the environment.
    func neoBrutalism(theme: NBTheme) -> some View {
        modifier(NBRootModifier(theme: theme, applyBackground: false))
    }

    /// Applies a custom NeoBrutalism theme and all component styles to the view tree,
    /// optionally filling the background with the theme's background color.
    ///
    /// - Parameters:
    ///   - theme: The ``NBTheme`` to inject into the environment.
    ///   - applyBackground: When `true`, wraps the content in the theme's background
    ///     color (ignoring safe area). Defaults to `false`.
    func neoBrutalism(theme: NBTheme, applyBackground: Bool) -> some View {
        modifier(NBRootModifier(theme: theme, applyBackground: applyBackground))
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    ScrollView {
        VStack(alignment: .leading, spacing: 20) {
            Button("Styled Button") {}

            Toggle("Checklist Item", isOn: .constant(true))

            TextField("Enter text...", text: .constant(""))

            ProgressView(value: 0.6)

            DisclosureGroup("Expand Me") {
                Text("Hidden content revealed!")
            }

            GroupBox("Card") {
                Text("Native GroupBox as a card.")
            }
        }
        .padding()
    }
    .neoBrutalism()
}
