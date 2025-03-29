import SwiftUI

public struct NBTabsContent<Content: View>: View {
    @Environment(\.nbSelectedTabItem) private var selectedTabItem: AnyEquatable?

    let tabItem: AnyEquatable
    let content: Content

    private var isSelected: Bool {
        selectedTabItem?.isEqual(tabItem) ?? false
    }

    public init(tabItem: AnyEquatable, @ViewBuilder content: () -> Content) {
        self.tabItem = tabItem
        self.content = content()
    }

    public var body: some View {
        if isSelected { content }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var value = 0

    VStack(spacing: 24.0) {
        NBFlatCard {
            NBTabsContent(tabItem: 0) {
                Text("First")
            }
        }
    }
    .environment(\.nbSelectedTabItem, 0)
}
