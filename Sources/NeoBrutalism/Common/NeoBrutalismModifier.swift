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
            .toggleStyle(.neoBrutalism) // switch — native Toggle semantics (T10 decision)
            .textFieldStyle(.neoBrutalism)
            .progressViewStyle(.neoBrutalism)
            .gaugeStyle(.neoBrutalism)
            .labelStyle(.neoBrutalism)
            .labeledContentStyle(.neoBrutalism)
            .menuStyle(.neoBrutalism) // styles the trigger; the dropdown stays native
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
    /// Applies the NeoBrutalism theme and every default component style to this view tree.
    ///
    /// Apply once at the root of your hierarchy to give every supported SwiftUI control the
    /// neobrutalism look. The styled protocols are: `Button`, `Toggle`, `TextField`/`SecureField`,
    /// `ProgressView`, `Gauge`, `Label`, `LabeledContent`, `Menu` (trigger only), `DisclosureGroup`,
    /// `ControlGroup`, and `GroupBox`.
    ///
    /// Two deliberate omissions:
    /// - The default `Toggle` style is the **switch**, matching native `Toggle` semantics. Opt into
    ///   the checkbox per subtree with `.toggleStyle(.neoBrutalismCheckbox)`.
    /// - `List`/`Form` and navigation chrome can't be styled through the environment — use the
    ///   `nbList()` / `nbListRow(elevated:)` and `nbNavigationBar()` helpers on those views.
    ///
    /// ```swift
    /// ContentView().neoBrutalism()                      // themed controls
    /// ContentView().neoBrutalism(applyBackground: true) // …plus a themed background fill
    /// ```
    ///
    /// - Parameters:
    ///   - theme: The ``NBTheme`` to inject. Defaults to ``NBTheme/default``.
    ///   - applyBackground: When `true`, also fills the safe-area-ignoring background with
    ///     `theme.background`, so a two-line app is fully styled. Defaults to `false`.
    func neoBrutalism(theme: NBTheme = .default, applyBackground: Bool = false) -> some View {
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
