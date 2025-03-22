import SwiftUI

public struct TabsContent<Content: View>: View {
    @Environment(\.neoBrutalism_selectedTabItem) private var selectedTabItem: AnyEquatable?

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
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    @Previewable @State var value = 0

    VStack(spacing: 24.0) {
        FlatCard {
            TabsContent(tabItem: 0) {
                Text("First")
            }
        }
    }
    .environment(\.neoBrutalism_selectedTabItem, 0)
}
