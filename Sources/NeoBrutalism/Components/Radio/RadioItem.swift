import SwiftUI

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

    public init(
        value: AnyEquatable,
        @ViewBuilder label: () -> Label
    ) {
        self.value = value
        self.label = label()
    }

    public var body: some View {
        HStack(spacing: theme.smspacing) {
            NBRadioIndicator(selected: selected)
            label
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if isEnabled {
                withAnimation(nbPressAnimation(reduceMotion: reduceMotion)) {
                    radioItemDidSelect(value)
                }
            }
        }
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
