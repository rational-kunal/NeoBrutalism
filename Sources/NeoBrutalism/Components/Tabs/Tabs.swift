import SwiftUI

extension EnvironmentValues {
    @Entry var neoBrutalism_tabItemDidSelect: Tabs.TabItemDidSelect = { _ in }
    @Entry var neoBrutalism_selectedTabItem: AnyEquatable? = nil
}

public struct Tabs<Content: View, ValueType: Equatable>: View {
    typealias TabItemDidSelect = (AnyEquatable) -> Void

    @Environment(\.neoBrutalismTheme) private var theme: Theme
    @Binding private var selectedTabItem: AnyEquatable
    let content: Content

    public init(selectedTabItem: Binding<ValueType>, @ViewBuilder content: () -> Content) {
        _selectedTabItem = Binding(
            get: { selectedTabItem.wrappedValue },
            set: { if let newValue = $0 as? ValueType { selectedTabItem.wrappedValue = newValue } }
        )
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.smspacing) {
            content
        }
        .environment(\.neoBrutalism_selectedTabItem, selectedTabItem)
        .environment(\.neoBrutalism_tabItemDidSelect) { selectedTabItem = $0 }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    @Previewable @State var value = 0

    VStack(spacing: 24.0) {
        Tabs(selectedTabItem: $value) {
            TabsList {
                TabsTrigger(tabItem: 0) { Text("First") }
                TabsTrigger(tabItem: 1) { Text("Second") }
            }
            FlatCard {
                ZStack {
                    TabsContent(tabItem: 0) {
                        Text("First")
                    }
                    TabsContent(tabItem: 1) {
                        VStack {
                            Text("Second")
                            Text("Second")
                        }
                    }
                }
            }
        }
        Spacer()
    }
}
