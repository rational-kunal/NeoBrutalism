import SwiftUI

extension EnvironmentValues {
    @Entry var neoBrutalism_radioItemDidSelect: RadioGroup.RadioItemDidSelect = { _ in }
    @Entry var neoBrutalism_selectedRadioItemValue: AnyEquatable? = nil
}

public struct RadioIndicator: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme

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

public struct RadioItem<Label>: View where Label: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme
    @Environment(\.neoBrutalism_selectedRadioItemValue) var selectedRadioItemValue: AnyEquatable?
    @Environment(\.neoBrutalism_radioItemDidSelect) var radioItemDidSelect: RadioGroup.RadioItemDidSelect

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
            RadioIndicator(selected: selected)
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

public struct RadioGroup<Content, ValueType>: View where Content: View, ValueType: Equatable {
    typealias RadioItemDidSelect = (AnyEquatable) -> Void

    @Environment(\.neoBrutalismTheme) var theme: Theme

    @Binding var value: AnyEquatable
    let content: Content

    public init(
        value: Binding<ValueType>,
        @ViewBuilder content: () -> Content
    ) {
        // Convert to Binding<any Equatable>
        _value = Binding<AnyEquatable>(
            get: { value.wrappedValue },
            set: { newValue in
                if let newValue = newValue as? ValueType {
                    value.wrappedValue = newValue
                }
            }
        )
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.smspacing) {
            content
        }
        .environment(\.neoBrutalism_selectedRadioItemValue, value)
        .environment(\.neoBrutalism_radioItemDidSelect) { value in
            self.value = value
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    @Previewable @State var value = 0
    VStack(spacing: 24.0) {
        Text("\(value)")
            .font(.caption)

        RadioGroup(value: $value) {
            RadioItem(value: 0) {
                Text("First")
            }

            RadioItem(value: 1) {
                Text("Second")
            }
        }

        RadioGroup(value: $value) {
            Text("Radio")
                .font(.title)

            RadioItem(value: 0) {
                Text("First")
            }
            RadioItem(value: 1) {
                Text("Second")
            }
            RadioItem(value: 2) {
                Text("Thhird")
            }
        }
    }
}
