import SwiftUI

public struct TabsTrigger<Label: View>: View {
    @Environment(\.neoBrutalismTheme) private var theme: Theme
    @Environment(\.neoBrutalism_selectedTabItem) private var selectedTabItem: AnyEquatable?
    @Environment(\.neoBrutalism_tabItemDidSelect) private var tabsItemDidSelect: Tabs.TabItemDidSelect

    let tabItem: AnyEquatable
    let label: Label

    private var isSelected: Bool {
        selectedTabItem?.isEqual(tabItem) ?? false
    }

    public init(tabItem: AnyEquatable, @ViewBuilder label: () -> Label) {
        self.tabItem = tabItem
        self.label = label()
    }

    public var body: some View {
        let styledLabel = label
            .frame(maxWidth: .infinity)
            .padding(theme.smpadding)
            .contentShape(Rectangle())
            .onTapGesture { withAnimation(.interactiveSpring) {
                tabsItemDidSelect(tabItem)
            }
            }

        if isSelected {
            styledLabel.neoBrutalismBox(elevated: false)
        } else {
            styledLabel
        }
    }
}
