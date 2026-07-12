import SwiftUI

/// One action revealed by ``SwiftUI/View/nbSwipeActions(edge:allowsFullSwipe:actions:)``.
public struct NBSwipeAction: Identifiable {
    public let id = UUID()
    let title: String
    let systemImage: String?
    let role: ButtonRole?
    let tint: Color?
    let action: () -> Void

    /// Creates a swipe action with a title, optional icon, role, and custom tint.
    /// - Parameters:
    ///   - title: The text label for this action.
    ///   - systemImage: An optional SF Symbol name.
    ///   - role: Optional role; `.destructive` fills with `theme.destructive`.
    ///   - tint: Optional color override; defaults by role.
    ///   - action: Closure invoked when the action is triggered.
    public init(
        _ title: String,
        systemImage: String? = nil,
        role: ButtonRole? = nil,
        tint: Color? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.role = role
        self.tint = tint
        self.action = action
    }
}

// MARK: - Modifier

struct NBSwipeActionsModifier: ViewModifier {
    @Environment(\.nbTheme) private var theme: NBTheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    let edge: HorizontalEdge
    let allowsFullSwipe: Bool
    let actions: [NBSwipeAction]
    let initialOffset: CGFloat  // For testing; can seed offset at creation time

    @State private var offset: CGFloat = 0
    @State private var isAnimatingOut = false

    private var estimatedActionWidth: CGFloat {
        theme.xlsize + theme.padding * 2 + theme.smspacing
    }

    private var totalActionsWidth: CGFloat {
        CGFloat(actions.count) * estimatedActionWidth
    }

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let rowWidth = geometry.size.width
            let fullSwipeThreshold = rowWidth * 0.6
            let snapThreshold: CGFloat = 15

            ZStack(alignment: edge == .trailing ? .trailing : .leading) {
                // Action tiles
                HStack(spacing: 0) {
                    ForEach(actions) { action in
                        let fillColor = action.role == .destructive
                            ? theme.destructive
                            : (action.tint ?? theme.main)
                        let textColor = action.role == .destructive
                            ? theme.destructiveText
                            : theme.mainText

                        Button {
                            action.action()
                        } label: {
                            VStack(alignment: .center, spacing: theme.smspacing) {
                                if let systemImage = action.systemImage {
                                    Image(systemName: systemImage)
                                        .font(.body.weight(.semibold))
                                }
                                Text(action.title)
                                    .font(.caption)
                                    .lineLimit(1)
                            }
                            .foregroundStyle(textColor)
                            .frame(maxHeight: .infinity)
                            .frame(width: estimatedActionWidth)
                            .padding(theme.padding)
                            .background(fillColor)
                            .overlay {
                                Rectangle()
                                    .stroke(theme.border, lineWidth: theme.borderWidth)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(width: totalActionsWidth)

                // Content with drag gesture
                content
                    .contentShape(Rectangle())
                    .offset(x: offsetForEdge(offset, edge: edge))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let translation = edge == .trailing
                                    ? value.translation.width
                                    : -value.translation.width

                                if allowsFullSwipe {
                                    offset = translation
                                } else {
                                    offset = min(0, max(translation, -totalActionsWidth))
                                }
                            }
                            .onEnded { value in
                                let translation = edge == .trailing
                                    ? value.translation.width
                                    : -value.translation.width

                                // Check for full-swipe action
                                if allowsFullSwipe,
                                   abs(translation) > fullSwipeThreshold,
                                   let firstAction = actions.first {
                                    let animation: Animation? = reduceMotion
                                        ? .none
                                        : .spring(response: 0.32, dampingFraction: 0.58, blendDuration: 0)
                                    withAnimation(animation) {
                                        isAnimatingOut = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        firstAction.action()
                                    }
                                } else {
                                    // Snap open or closed
                                    let shouldOpen = abs(translation) > snapThreshold
                                    let targetOffset: CGFloat = shouldOpen
                                        ? (edge == .trailing ? -totalActionsWidth : totalActionsWidth)
                                        : 0

                                    let animation: Animation? = reduceMotion
                                        ? .none
                                        : .interactiveSpring()
                                    withAnimation(animation) {
                                        offset = targetOffset
                                    }
                                }
                            }
                    )
                    .opacity(isAnimatingOut ? 0 : 1)
            }
            .frame(height: geometry.size.height)
        }
        .onAppear {
            offset = initialOffset
        }
        .accessibilityElement(children: .contain)
        .accessibilityActions {
            // Exposes every swipe action directly to VoiceOver/Switch Control, so
            // assistive-tech users can trigger them without performing the drag gesture.
            ForEach(actions) { action in
                Button(action.title, action: action.action)
            }
        }
    }

    private func offsetForEdge(_ offset: CGFloat, edge: HorizontalEdge) -> CGFloat {
        edge == .trailing ? offset : -offset
    }
}

// MARK: - Public API

public extension View {
    /// Reveals neobrutalist action tiles when the row is dragged from `edge` — a themed,
    /// bordered alternative to SwiftUI's `.swipeActions`, which only lets you tint the fill.
    ///
    /// Intended for rows in a `LazyVStack`/`ScrollView`. **Not** `List`: List owns its own pan
    /// gesture and fights a custom one — use native `.swipeActions` + `.tint(theme.destructive)`
    /// there (see T12).
    ///
    /// ```swift
    /// ItemRow(item)
    ///     .nbListRow()
    ///     .nbSwipeActions(actions: [
    ///         NBSwipeAction("Delete", systemImage: "trash", role: .destructive) {
    ///             delete(item)
    ///         }
    ///     ])
    /// ```
    func nbSwipeActions(
        edge: HorizontalEdge = .trailing,
        allowsFullSwipe: Bool = true,
        actions: [NBSwipeAction],
        initialOffset: CGFloat = 0
    ) -> some View {
        modifier(
            NBSwipeActionsModifier(
                edge: edge,
                allowsFullSwipe: allowsFullSwipe,
                actions: actions,
                initialOffset: initialOffset
            )
        )
    }
}

// MARK: - Preview

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack {
        Text("Swipe Actions")
            .font(.headline)

        HStack {
            Text("Item to delete")
                .font(.body)
            Spacer()
        }
        .padding(12)
        .background(.white)
        .border(.black, width: 2)
        .nbSwipeActions(actions: [
            NBSwipeAction("Delete", systemImage: "trash", role: .destructive) {
                // Action
            }
        ], initialOffset: -100)
        .frame(height: 60)
    }
    .padding(12)
}
