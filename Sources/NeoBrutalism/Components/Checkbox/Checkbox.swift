import SwiftUI

public extension ToggleStyle where Self == NBCheckboxToggleStyle {
    /// Checkbox look for `Toggle`.
    static var neoBrutalismCheckbox: NBCheckboxToggleStyle { .init() }

    @available(*, deprecated, renamed: "neoBrutalismCheckbox")
    static var neoBrutalismChecklist: NBCheckboxToggleStyle { .init() }
}

/// Renders a `Toggle` as a bordered checkbox with a hand-drawn check mark. Apply via
/// `.toggleStyle(.neoBrutalismCheckbox)`.
public struct NBCheckboxToggleStyle: ToggleStyle {
    @Environment(\.nbTheme) var theme: NBTheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation(nbPressAnimation(reduceMotion: reduceMotion)) {
                configuration.isOn.toggle()
            }
        } label: {
            HStack {
                makeCheckbox(configuration: configuration)
                configuration.label
            }
        }
        .buttonStyle(.plain)
        .nbDisabledEffect()
    }
}

extension NBCheckboxToggleStyle {
    private func makeCheckbox(configuration: Configuration) -> some View {
        ZStack {
            if configuration.isOn {
                theme.main
                    .padding(theme.borderWidth / 2) // Border to get the space it needs
            } else {
                theme.clear
            }

            // Checkbox
            if configuration.isOn {
                checkboxShape
            }
        }
        .overlay(
            Rectangle()
                .stroke(theme.border, lineWidth: theme.borderWidth)
        )
        .frame(width: theme.size, height: theme.size)
    }

    private var checkboxShape: some View {
        NBCheckboxShape()
            .stroke(theme.border, style: StrokeStyle(lineWidth: theme.borderWidth, lineCap: .round, lineJoin: .round))
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var checkboxState1 = true
    @Previewable @State var checkboxState2 = false

    VStack {
        HStack {
            Toggle(isOn: $checkboxState1) {
                Text("Checkbox")
            }
        }

        Toggle(isOn: $checkboxState1) {}
            .disabled(true)

        Toggle(isOn: $checkboxState2) {}
            .disabled(true)

        Toggle(isOn: $checkboxState2) {}
    }.toggleStyle(.neoBrutalismCheckbox)
}
