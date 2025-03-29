import SwiftUI

public struct NBRadioIndicator: View {
    @Environment(\.nbTheme) var theme: NBTheme

    let selected: Bool

    public var body: some View {
        ZStack {
            Circle()
                .stroke(theme.border, lineWidth: theme.borderWidth)
                .frame(width: theme.size, height: theme.size)

            if selected {
                let innerCircleSize = theme.size - 4 * theme.borderWidth

                Circle()
                    .fill(theme.text)
                    .frame(width: innerCircleSize, height: innerCircleSize)
            }
        }
    }
}

public struct NBRadioItem<Label>: View where Label: View {
    @Environment(\.nbTheme) var theme: NBTheme
    @Environment(\.nbSelectedRadioItemValue) var selectedRadioItemValue: AnyEquatable?
    @Environment(\.nbRadioItemDidSelect) var radioItemDidSelect: NBRadioGroup.RadioItemDidSelect

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
            withAnimation(.interactiveSpring) {
                radioItemDidSelect(value)
            }
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var value = 0
    VStack(spacing: 24.0) {
        NBRadioItem(value: 0) {
            Text("Radio Item")
        }
    }
}
