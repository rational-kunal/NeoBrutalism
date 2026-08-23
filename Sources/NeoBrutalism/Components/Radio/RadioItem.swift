import SwiftUI

/// A single selectable row inside an `NBRadioGroup`.
///
/// Must be placed inside an `NBRadioGroup` — it reads the group's current selection and
/// selection callback from the environment, so it renders unselected and does nothing if
/// used standalone.
///
/// ```swift
/// NBRadioItem(value: 0) {
///     Text("First")
/// }
/// ```
public struct NBRadioItem<Label>: View where Label: View {
    @Environment(\.nbTheme) var theme: NBTheme
    @Environment(\.nbSelectedRadioItemValue) var selectedRadioItemValue: AnyEquatable?
    @Environment(\.nbRadioItemDidSelect) var radioItemDidSelect: NBRadioItemDidSelect
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.isEnabled) private var isEnabled

    var value: AnyEquatable
    var selected: Bool {
        if let selectedRadioItemValue {
            return selectedRadioItemValue.isEqual(value)
        }
        return false
    }

    var label: Label

    /// Creates a radio item.
    /// - Parameters:
    ///   - value: The value this row represents; compared against the enclosing `NBRadioGroup`'s binding to decide selection.
    ///   - label: The row's label content.
    public init(
        value: AnyEquatable,
        @ViewBuilder label: () -> Label
    ) {
        self.value = value
        self.label = label()
    }

    public var body: some View {
        Button(action: {
            if isEnabled {
                withAnimation(nbPressAnimation(reduceMotion: reduceMotion)) {
                    radioItemDidSelect(value)
                }
            }
        }) {
            HStack(spacing: theme.smspacing) {
                NBRadioIndicator(selected: selected)
                label
            }
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(selected ? [.isSelected] : [])
        .nbDisabledEffect()
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
