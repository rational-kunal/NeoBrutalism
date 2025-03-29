import SwiftUI

public struct NBInput: View {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nbTheme) var theme: NBTheme

    @Binding private var text: String
    private let placeholder: String?

    public init(text: Binding<String>, placeholder: String? = nil) {
        _text = text
        self.placeholder = placeholder
    }

    public var body: some View {
        TextField(placeholder ?? "Input", text: $text)
            .textFieldStyle(.plain)
            .padding(theme.padding)
            .background(theme.bw)
            .nbBox(elevated: false)
            .opacity(isEnabled ? 1.0 : 0.5)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var inputValue = ""
    @Previewable @State var switchState2 = false

    VStack {
        NBInput(text: $inputValue)
        NBInput(text: $inputValue)
            .disabled(true)
    }
}
