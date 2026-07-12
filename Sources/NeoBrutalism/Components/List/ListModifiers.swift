import SwiftUI

struct NBListModifier: ViewModifier {
    @Environment(\.nbTheme) private var theme: NBTheme

    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .background(theme.background)
            .listRowSpacing(theme.smspacing)
    }
}

struct NBListRowModifier: ViewModifier {
    @Environment(\.nbTheme) private var theme: NBTheme

    let elevated: Bool

    func body(content: Content) -> some View {
        content
            .padding(theme.padding)
            .background(theme.bw)
            .nbBox(elevated: elevated)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(
                top: theme.smspacing / 2,
                leading: theme.padding,
                bottom: theme.smspacing / 2,
                trailing: theme.padding
            ))
    }
}

public extension View {
    /// Restyles a `List` or `Form` container: hides the system background so the
    /// theme background shows through, and tightens section spacing.
    ///
    /// Apply to the `List`/`Form` itself. Style each row with ``nbListRow(elevated:)``.
    ///
    /// ```swift
    /// List {
    ///     ForEach(items) { item in
    ///         ItemRow(item).nbListRow()
    ///     }
    /// }
    /// .nbList()
    /// ```
    func nbList() -> some View {
        modifier(NBListModifier())
    }

    /// Styles one list row as a neobrutalism card: themed surface, thick border,
    /// hidden system separator/background.
    ///
    /// Apply to the row's content view (inside `ForEach`), not to the `List`.
    ///
    /// ```swift
    /// List {
    ///     ForEach(items) { item in
    ///         Text(item.title)
    ///             .nbListRow()
    ///     }
    /// }
    /// .nbList()
    /// ```
    func nbListRow(elevated: Bool = false) -> some View {
        modifier(NBListRowModifier(elevated: elevated))
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    List {
        ForEach(0..<3, id: \.self) { index in
            Text("Row \(index + 1)")
                .nbListRow()
        }
    }
    .nbList()
    .frame(height: 300)
}
