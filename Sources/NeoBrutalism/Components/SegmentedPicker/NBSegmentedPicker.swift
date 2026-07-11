import SwiftUI

/// A neo-brutalism styled segmented picker for selecting from a set of options.
///
/// `NBSegmentedPicker` provides a horizontal button group where the selected item is highlighted
/// with the theme's main color and others use the bw background color.
///
/// ```swift
/// @State var selection = "One"
/// NBSegmentedPicker(selection: $selection) {
///     Text("One").nbSegment("One")
///     Text("Two").nbSegment("Two")
///     Text("Three").nbSegment("Three")
/// }
/// ```
public struct NBSegmentedPicker<Value: Hashable>: View {
    @Environment(\.nbTheme) var theme: NBTheme

    @Binding private var selection: Value
    private let content: [NBSegmentItem<Value>]

    /// Creates a segmented picker.
    /// - Parameters:
    ///   - selection: A binding to the currently selected value.
    ///   - content: A view builder providing `NBSegmentItem` views via the `.nbSegment(_:)` modifier.
    public init(selection: Binding<Value>, @NBSegmentBuilder<Value> content: () -> [NBSegmentItem<Value>]) {
        _selection = selection
        self.content = content()
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(content.enumerated()), id: \.element.tag) { index, item in
                Button {
                    withAnimation(.interactiveSpring()) {
                        selection = item.tag
                    }
                } label: {
                    item.label
                        .foregroundStyle(selection == item.tag ? theme.mainText : theme.text)
                        .padding(.vertical, theme.padding)
                        .padding(.horizontal, theme.xlpadding)
                        .frame(maxWidth: .infinity)
                        .background(selection == item.tag ? theme.main : theme.bw)
                }
                .buttonStyle(.plain)

                if index < content.count - 1 {
                    Rectangle()
                        .fill(theme.border)
                        .frame(width: theme.borderWidth)
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .nbBox()
    }
}

/// A single segment item in an `NBSegmentedPicker`.
public struct NBSegmentItem<Value: Hashable> {
    let tag: Value
    let label: AnyView
}

/// Result builder for constructing segment items.
@resultBuilder
public struct NBSegmentBuilder<Value: Hashable> {
    public static func buildBlock(_ components: NBSegmentItem<Value>...) -> [NBSegmentItem<Value>] {
        components
    }
}

public extension View {
    /// Tags a view as a segment in an `NBSegmentedPicker`.
    /// - Parameter tag: The hashable value this segment represents.
    func nbSegment<Value: Hashable>(_ tag: Value) -> NBSegmentItem<Value> {
        NBSegmentItem(tag: tag, label: AnyView(self))
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var selected = "One"
    @Previewable @State var size = 0

    VStack(spacing: 20) {
        NBSegmentedPicker(selection: $selected) {
            Text("One").nbSegment("One")
            Text("Two").nbSegment("Two")
            Text("Three").nbSegment("Three")
        }

        NBSegmentedPicker(selection: $size) {
            Text("S").nbSegment(0)
            Text("M").nbSegment(1)
            Text("L").nbSegment(2)
            Text("XL").nbSegment(3)
        }

        Text("Selected: \(selected), Size: \(size)")
    }
    .padding()
}
