import SwiftUI

extension EnvironmentValues {
    @Entry var neoBrutalism_radioItemDidSelect: RadioGroup.RadioItemDidSelect = { _ in }
    @Entry var neoBrutalism_selectedRadioItemValue: Int? = nil
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
    @Environment(\.neoBrutalism_selectedRadioItemValue) var selectedRadioItemValue: Int?
    @Environment(\.neoBrutalism_radioItemDidSelect) var radioItemDidSelect: RadioGroup.RadioItemDidSelect

    var value: Int
    var selected: Bool { selectedRadioItemValue == value }
    var label: Label

    public init(
        value: Int,
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

public struct RadioGroup<Content>: View where Content: View {
    typealias RadioItemDidSelect = (Int) -> Void

    @Environment(\.neoBrutalismTheme) var theme: Theme

    @Binding var value: Int
    let content: Content

    public init(
        value: Binding<Int>,
        @ViewBuilder content: () -> Content
    ) {
        _value = value
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
