import SwiftUI

extension EnvironmentValues {
    @Entry var nbCollapsableDidToggle: NBCollapsableDidToggle = {}
    @Entry var nbCollapsableIsExpanded: Bool = false
}

/// Content that's only rendered while the enclosing `NBCollapsable` is expanded.
///
/// Must be placed inside an `NBCollapsable` — it reads the expanded state from the
/// environment, so used standalone it never renders its content.
public struct NBCollapsableContent<Content>: View where Content: View {
    @Environment(\.nbCollapsableIsExpanded) var isExpanded

    let content: Content

    /// Creates collapsable content.
    /// - Parameter content: The content to show only while expanded.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        if isExpanded {
            content
        }
    }
}

/// A tappable control that toggles the enclosing `NBCollapsable`'s expanded state.
///
/// Must be placed inside an `NBCollapsable` — it reads the toggle callback from the
/// environment, so used standalone tapping it does nothing.
public struct NBCollapsibleTrigger<Trigger>: View where Trigger: View {
    @Environment(\.nbCollapsableDidToggle) var collapsableDidToggle

    let trigger: Trigger

    /// Creates a collapsible trigger.
    /// - Parameter trigger: The tappable content, e.g. a chevron icon.
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

typealias NBCollapsableDidToggle = () -> Void

/// A container that shares expand/collapse state with any `NBCollapsibleTrigger` and
/// `NBCollapsableContent` placed inside it, letting you build a custom expandable layout
/// (e.g. a `GroupBox` with a chevron in its header) out of plain views instead of a fixed
/// accordion shape.
///
/// ```swift
/// NBCollapsable(isExpanded: $isExpanded) {
///     GroupBox {
///         HStack {
///             Text("Header")
///             Spacer()
///             NBCollapsibleTrigger {
///                 Image(systemName: "chevron.up.chevron.down")
///             }
///         }
///     }
///     NBCollapsableContent {
///         Text("Content")
///     }
/// }
/// ```
public struct NBCollapsable<Content>: View where Content: View {
    @Environment(\.nbTheme) var theme: NBTheme

    typealias CollapsableDidToggle = () -> Void

    @Binding var isExpanded: Bool
    let content: Content

    /// Creates a collapsable container.
    /// - Parameters:
    ///   - isExpanded: A binding to the shared expanded state.
    ///   - content: The container's content — typically a mix of always-visible views,
    ///     an `NBCollapsibleTrigger`, and one or more `NBCollapsableContent` views.
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
            GroupBox {
                HStack {
                    Text("Some")
                    Spacer()
                    NBCollapsibleTrigger {
                        Image(systemName: "chevron.up.chevron.down.square.fill")
                    }
                }
            }

            GroupBox {
                Text("another card")
            }
            .groupBoxStyle(.neoBrutalism(type: .neutral, elevated: false))

            NBCollapsableContent {
                GroupBox {
                    Text("Content")
                    Text("Content")
                    Text("Content")
                }
            }
        }
        .groupBoxStyle(.neoBrutalism(elevated: false))
    }
}
