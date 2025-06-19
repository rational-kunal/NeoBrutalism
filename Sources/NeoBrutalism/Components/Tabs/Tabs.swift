import SwiftUI

extension EnvironmentValues {
    @Entry var nbTabItemDidSelect: NBTabItemDidSelect = { _ in }
    @Entry var nbSelectedTabItem: AnyEquatable? = nil
}

typealias NBTabItemDidSelect = (AnyEquatable) -> Void
public struct NBTabs<Content: View, ValueType: Equatable>: View {

    @Environment(\.nbTheme) private var theme: NBTheme
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
        .environment(\.nbSelectedTabItem, selectedTabItem)
        .environment(\.nbTabItemDidSelect) { selectedTabItem = $0 }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var value = 0

    VStack(spacing: 24.0) {
        NBTabs(selectedTabItem: $value) {
            NBTabsList {
                NBTabsTrigger(tabItem: 0) { Text("First") }
                NBTabsTrigger(tabItem: 1) { Text("Second") }
            }
            NBFlatCard {
                ZStack {
                    NBTabsContent(tabItem: 0) {
                        Text("First")
                    }
                    NBTabsContent(tabItem: 1) {
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
