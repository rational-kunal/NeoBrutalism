import SwiftUI

public extension TextFieldStyle where Self == NBInputStyle {
    static var neoBrutalism: NBInputStyle { .init() }
}

public struct NBInputStyle: @preconcurrency TextFieldStyle {
    @Environment(\.nbTheme) var theme: NBTheme

    @MainActor public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(theme.padding)
            .background(theme.bw)
            .nbBox(elevated: false)
            .nbDisabledEffect()
    }
}

public extension View {
    /// Gives a `TextEditor` the neobrutalism input treatment: themed surface,
    /// thick border, flat (no shadow) — matching `.textFieldStyle(.neoBrutalism)`.
    ///
    /// ```swift
    /// TextEditor(text: $notes)
    ///     .nbTextEditor()
    ///     .frame(height: 120)
    /// ```
    func nbTextEditor() -> some View {
        NBTextEditorModifier(content: self)
    }
}

struct NBTextEditorModifier<Content: View>: View {
    @Environment(\.nbTheme) var theme: NBTheme

    let content: Content

    var body: some View {
        content
            .scrollContentBackground(.hidden)
            .padding(theme.smpadding)
            .background(theme.bw)
            .nbBox(elevated: false)
            .nbDisabledEffect()
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var inputValue = ""
    @Previewable @State var editorValue = ""

    VStack {
        TextField("Input", text: $inputValue)
            .textFieldStyle(.neoBrutalism)

        TextField("Input", text: $inputValue)
            .disabled(true)
            .textFieldStyle(.neoBrutalism)

        SecureField("Password", text: $inputValue)
            .textFieldStyle(.neoBrutalism)

        TextEditor(text: $editorValue)
            .nbTextEditor()
            .frame(height: 100)
    }
}
