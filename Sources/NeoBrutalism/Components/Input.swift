import SwiftUI

public struct Input: View {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.neoBrutalismTheme) var theme: Theme

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
            .neoBrutalismBox(elevated: false)
            .opacity(isEnabled ? 1.0 : 0.5)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    @Previewable @State var inputValue = ""
    @Previewable @State var switchState2 = false

    VStack {
        Input(text: $inputValue)
        Input(text: $inputValue)
            .disabled(true)
    }
}
