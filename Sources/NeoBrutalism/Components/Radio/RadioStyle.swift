import SwiftUI

public extension ToggleStyle where Self == NBRadioStyle {
    /// Radio-button look for a single `Toggle`. For a mutually-exclusive group, prefer
    /// `NBRadioGroup` + `NBRadioItem` instead — this style is for a single standalone toggle
    /// that should read visually as a radio dot rather than a checkbox or switch.
    static var neoBrutalismRadio: NBRadioStyle { .init() }
}

/// Renders a `Toggle` as a radio dot (`NBRadioIndicator`) instead of a checkbox or switch.
/// Apply via `.toggleStyle(.neoBrutalismRadio)`.
public struct NBRadioStyle: ToggleStyle {
    @Environment(\.nbTheme) var theme: NBTheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation(nbPressAnimation(reduceMotion: reduceMotion)) {
                configuration.isOn.toggle()
            }
        } label: {
            HStack {
                makeRadio(configuration: configuration)
                configuration.label
            }
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(configuration.isOn ? [.isSelected] : [])
        .nbDisabledEffect()
    }
}

extension NBRadioStyle {
    private func makeRadio(configuration: Configuration) -> some View {
        NBRadioIndicator(selected: configuration.isOn)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var value = 0
    VStack(spacing: 24.0) {
        NBRadioItem(value: 0) {
            Text("Radio Item")
        }

        Toggle(isOn: .constant(false)) {
            Text("Radio Item")
        }.toggleStyle(.neoBrutalismRadio)

        Toggle(isOn: .constant(true)) {
            Text("Radio Item")
        }.toggleStyle(.neoBrutalismRadio)
    }
}
