import SwiftUI

extension EnvironmentValues {
    @Entry var nbRadioItemDidSelect: NBRadioItemDidSelect = { _ in }
    @Entry var nbSelectedRadioItemValue: AnyEquatable? = nil
}

typealias NBRadioItemDidSelect = (AnyEquatable) -> Void

/// A group of mutually-exclusive `NBRadioItem` rows — the drop-in for radio selection,
/// which has no native SwiftUI control on iOS.
///
/// Any `Equatable` type can back the selection; `NBRadioItem`'s own `value` is matched
/// against the group's binding to decide which row renders selected.
///
/// ```swift
/// @State var choice = 0
/// NBRadioGroup(value: $choice) {
///     NBRadioItem(value: 0) { Text("First") }
///     NBRadioItem(value: 1) { Text("Second") }
/// }
/// ```
public struct NBRadioGroup<Content, ValueType>: View where Content: View, ValueType: Equatable {
    @Environment(\.nbTheme) var theme: NBTheme

    @Binding var value: AnyEquatable
    let content: Content

    /// Creates a radio group.
    /// - Parameters:
    ///   - value: A binding to the currently selected value, shared with every `NBRadioItem` inside `content`.
    ///   - content: The group's rows — typically a series of `NBRadioItem`s, plus any other content (e.g. a heading).
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
        .accessibilityElement(children: .contain)
        .environment(\.nbSelectedRadioItemValue, value)
        .environment(\.nbRadioItemDidSelect) { value in
            self.value = value
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var value = 0
    VStack(spacing: 24.0) {
        Text("\(value)")
            .font(.caption)

        NBRadioGroup(value: $value) {
            NBRadioItem(value: 0) {
                Text("First")
            }

            NBRadioItem(value: 1) {
                Text("Second")
            }
        }

        NBRadioGroup(value: $value) {
            Text("Radio")
                .font(.title)

            NBRadioItem(value: 0) {
                Text("First")
            }
            NBRadioItem(value: 1) {
                Text("Second")
            }
            NBRadioItem(value: 2) {
                Text("Third")
            }
        }
    }
}
