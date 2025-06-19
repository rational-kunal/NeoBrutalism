import SwiftUI

public struct NBTabsTrigger<Label: View>: View {
    @Environment(\.nbTheme) private var theme: NBTheme
    @Environment(\.nbSelectedTabItem) private var selectedTabItem: AnyEquatable?
    @Environment(\.nbTabItemDidSelect) private var tabsItemDidSelect: NBTabItemDidSelect

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
            styledLabel
                .nbBox(elevated: false)
                .foregroundStyle(theme.mainText)
        } else {
            styledLabel
        }
    }
}
