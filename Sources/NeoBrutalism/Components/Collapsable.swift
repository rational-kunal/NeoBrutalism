import SwiftUI

extension EnvironmentValues {
    @Entry var neoBrutalism_collapsableDidToggle: Collapsable.CollapsableDidToggle = {}
    @Entry var neoBrutalism_collapsableIsExpanded: Bool = false
}

struct CollapsableContent<Content>: View where Content: View {
    @Environment(\.neoBrutalism_collapsableIsExpanded) var isExpanded

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        if isExpanded {
            content
        }
    }
}

struct CollapsibleTrigger<Trigger>: View where Trigger: View {
    @Environment(\.neoBrutalism_collapsableDidToggle) var collapsableDidToggle

    let trigger: Trigger

    init(@ViewBuilder trigger: () -> Trigger) {
        self.trigger = trigger()
    }

    var body: some View {
        trigger
            .contentShape(Rectangle())
            .onTapGesture {
                collapsableDidToggle()
            }
    }
}

struct Collapsable<Content>: View where Content: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme

    typealias CollapsableDidToggle = () -> Void

    @Binding var isExpanded: Bool
    let content: Content

    init(isExpanded: Binding<Bool>,
         @ViewBuilder content: () -> Content)
    {
        _isExpanded = isExpanded
        self.content = content()
    }

    var body: some View {
        VStack(spacing: theme.smspacing) {
            content
                .environment(\.neoBrutalism_collapsableIsExpanded, isExpanded)
                .environment(\.neoBrutalism_collapsableDidToggle) { isExpanded.toggle() }
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    @Previewable @State var isExapanded = true

    VStack {
        Collapsable(isExpanded: $isExapanded) {
            FlatCard {
                HStack {
                    Text("Some")
                    Spacer()
                    CollapsibleTrigger {
                        Image(systemName: "chevron.up.chevron.down.square.fill")
                    }
                }
            }

            FlatCard(type: .neutral) {
                Text("another card")
            }

            CollapsableContent {
                FlatCard(type: .default) {
                    Text("Content")
                    Text("Content")
                    Text("Content")
                }
            }
        }
    }
}
