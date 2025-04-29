import SwiftUI

public extension TextFieldStyle where Self == NBInputStyle {
    static var neoBrutalism: NBInputStyle { .init() }
}

public struct NBInputStyle: @preconcurrency TextFieldStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nbTheme) var theme: NBTheme

    @MainActor public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(theme.padding)
            .background(theme.bw)
            .nbBox(elevated: false)
            .opacity(isEnabled ? 1.0 : 0.5)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var inputValue = ""

    VStack {
        TextField("Input", text: $inputValue)
            .textFieldStyle(.neoBrutalism)

        TextField("Input", text: $inputValue)
            .disabled(true)
            .textFieldStyle(.neoBrutalism)
    }
}
