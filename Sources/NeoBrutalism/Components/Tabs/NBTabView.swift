import SwiftUI

/// A neo-brutalism styled inline tab view: a segmented trigger bar that switches the
/// content shown below it.
///
/// `NBTabView` mirrors the shape of SwiftUI's native `TabView` + `Tab(_:systemImage:value:)`
/// API, so adopting it is a rename. Unlike native `TabView` (a screen-level container with a
/// bottom bar), `NBTabView` renders *inline* tabs — a themed trigger list above the selected
/// tab's content — for switching sections within a page.
///
/// ```swift
/// @State var selection = House.gryffindor
///
/// NBTabView(selection: $selection) {
///     NBTab("Gryffindor", systemImage: "flame.fill", value: House.gryffindor) {
///         Text("Bravery and Daring!")
///     }
///     NBTab("Ravenclaw", systemImage: "book.fill", value: House.ravenclaw) {
///         Text("Wisdom and Learning!")
///     }
/// }
/// ```
///
/// The content area is unstyled — wrap it in a `GroupBox` styled with
/// `.groupBoxStyle(.neoBrutalism())` if you want it boxed.
public struct NBTabView<Value: Hashable>: View {
    @Environment(\.nbTheme) private var theme: NBTheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @Binding private var selection: Value
    private let tabs: [NBTab<Value>]

    /// Creates a tab view.
    /// - Parameters:
    ///   - selection: A binding to the value of the currently selected tab.
    ///   - content: A builder providing the ``NBTab``s. If no tab's value matches
    ///     `selection`, only the trigger bar is shown.
    public init(selection: Binding<Value>, @NBTabBuilder<Value> content: () -> [NBTab<Value>]) {
        _selection = selection
        self.tabs = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.smspacing) {
            triggerList

            if let selected = tabs.first(where: { $0.value == selection }) {
                selected.content
            }
        }
    }

    private var triggerList: some View {
        HStack(spacing: theme.smspacing) {
            ForEach(tabs, id: \.value) { tab in
                trigger(for: tab)
            }
        }
        .padding(theme.smpadding)
        .background(theme.main)
        .nbBox(elevated: false)
    }

    @ViewBuilder
    private func trigger(for tab: NBTab<Value>) -> some View {
        let isSelected = tab.value == selection

        let button = Button {
            withAnimation(nbPressAnimation(reduceMotion: reduceMotion)) {
                selection = tab.value
            }
        } label: {
            tab.label
                .frame(maxWidth: .infinity)
                .padding(theme.smpadding)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])

        if isSelected {
            button
                .foregroundStyle(theme.text)
                .nbBox(elevated: false)
        } else {
            button
                .foregroundStyle(theme.mainText)
        }
    }
}

/// A single tab in an ``NBTabView``: a trigger label plus the content shown while selected.
public struct NBTab<Value: Hashable> {
    let value: Value
    let label: AnyView
    let content: AnyView

    /// Creates a tab from a title and optional SF Symbol, mirroring native
    /// `Tab(_:systemImage:value:content:)`.
    /// - Parameters:
    ///   - title: The trigger's text.
    ///   - systemImage: An optional leading SF Symbol name.
    ///   - value: The hashable value this tab represents.
    ///   - content: The content shown while this tab is selected.
    public init(
        _ title: LocalizedStringKey,
        systemImage: String? = nil,
        value: Value,
        @ViewBuilder content: () -> some View
    ) {
        if let systemImage {
            self.label = AnyView(Label(title, systemImage: systemImage))
        } else {
            self.label = AnyView(Text(title))
        }
        self.value = value
        self.content = AnyView(content())
    }

    /// Creates a tab with a fully custom trigger label, mirroring native
    /// `Tab(value:content:label:)`.
    /// - Parameters:
    ///   - value: The hashable value this tab represents.
    ///   - content: The content shown while this tab is selected.
    ///   - label: The trigger's content (e.g. an icon).
    public init(
        value: Value,
        @ViewBuilder content: () -> some View,
        @ViewBuilder label: () -> some View
    ) {
        self.value = value
        self.content = AnyView(content())
        self.label = AnyView(label())
    }
}

/// Result builder for assembling ``NBTab``s, supporting `if`/`else` and `for` in the body.
@resultBuilder
public struct NBTabBuilder<Value: Hashable> {
    public static func buildBlock(_ components: [NBTab<Value>]...) -> [NBTab<Value>] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: NBTab<Value>) -> [NBTab<Value>] {
        [expression]
    }

    public static func buildArray(_ components: [[NBTab<Value>]]) -> [NBTab<Value>] {
        components.flatMap { $0 }
    }

    public static func buildOptional(_ component: [NBTab<Value>]?) -> [NBTab<Value>] {
        component ?? []
    }

    public static func buildEither(first component: [NBTab<Value>]) -> [NBTab<Value>] {
        component
    }

    public static func buildEither(second component: [NBTab<Value>]) -> [NBTab<Value>] {
        component
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var house = 0
    @Previewable @State var section = "account"

    VStack(spacing: 24.0) {
        NBTabView(selection: $house) {
            NBTab(value: 0) {
                GroupBox { Text("Bravery and Daring!") }
            } label: {
                Image(systemName: "flame.fill")
            }
            NBTab(value: 1) {
                GroupBox { Text("Cunning and Ambition!") }
            } label: {
                Image(systemName: "lanyardcard.fill")
            }
            NBTab(value: 2) {
                GroupBox { Text("Wisdom and Learning!") }
            } label: {
                Image(systemName: "book.fill")
            }
        }
        .groupBoxStyle(.neoBrutalism(elevated: false))

        NBTabView(selection: $section) {
            NBTab("Account", systemImage: "person.fill", value: "account") {
                Text("Manage your account.")
            }
            NBTab("Password", systemImage: "lock.fill", value: "password") {
                Text("Change your password.")
            }
        }

        Spacer()
    }
    .padding()
}
