import SwiftUI

extension EnvironmentValues {
    @Entry var nbCollapsableDidToggle: NBCollapsable.CollapsableDidToggle = {}
    @Entry var nbCollapsableIsExpanded: Bool = false
}

public struct NBCollapsableContent<Content>: View where Content: View {
    @Environment(\.nbCollapsableIsExpanded) var isExpanded

    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        if isExpanded {
            content
        }
    }
}

public struct NBCollapsibleTrigger<Trigger>: View where Trigger: View {
    @Environment(\.nbCollapsableDidToggle) var collapsableDidToggle

    let trigger: Trigger

    public init(@ViewBuilder trigger: () -> Trigger) {
        self.trigger = trigger()
    }

    public var body: some View {
        trigger
            .contentShape(Rectangle())
            .onTapGesture {
                collapsableDidToggle()
            }
    }
}

public struct NBCollapsable<Content>: View where Content: View {
    @Environment(\.nbTheme) var theme: NBTheme

    typealias CollapsableDidToggle = () -> Void

    @Binding var isExpanded: Bool
    let content: Content

    public init(isExpanded: Binding<Bool>,
                @ViewBuilder content: () -> Content)
    {
        _isExpanded = isExpanded
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: theme.smspacing) {
            content
                .environment(\.nbCollapsableIsExpanded, isExpanded)
                .environment(\.nbCollapsableDidToggle) { isExpanded.toggle() }
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var isExapanded = true

    VStack {
        NBCollapsable(isExpanded: $isExapanded) {
            NBFlatCard {
                HStack {
                    Text("Some")
                    Spacer()
                    NBCollapsibleTrigger {
                        Image(systemName: "chevron.up.chevron.down.square.fill")
                    }
                }
            }

            NBFlatCard(type: .neutral) {
                Text("another card")
            }

            NBCollapsableContent {
                NBFlatCard(type: .default) {
                    Text("Content")
                    Text("Content")
                    Text("Content")
                }
            }
        }
    }
}
