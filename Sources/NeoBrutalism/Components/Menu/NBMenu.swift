import SwiftUI

/// A neobrutalism-styled menu with a fully themed dropdown.
///
/// SwiftUI's built-in `Menu`/`MenuStyle` only lets you style the trigger label — the popup that
/// appears on tap is rendered by UIKit and can't be themed. `NBMenu` sidesteps that by presenting
/// its own dropdown in a dedicated overlay window, so both the trigger *and* the items get the
/// neobrutalism treatment (thick border, hard shadow, theme colors) and the dropdown always
/// renders above the rest of the app — even inside a `ScrollView`/`List` row that has sibling
/// content below it.
///
/// ```swift
/// NBMenu {
///     NBMenuItem("Edit", systemImage: "pencil") { edit() }
///     NBMenuItem("Duplicate", systemImage: "plus.square.on.square") { duplicate() }
///     NBMenuItem("Delete", systemImage: "trash", role: .destructive) { delete() }
/// } label: {
///     Text("Options")
/// }
/// ```
public struct NBMenu<Label: View>: View {
    @Environment(\.nbTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var isOpen = false
    @State private var triggerFrame: CGRect = .zero
    @State private var overlayWindow = NBOverlayWindow()

    private let label: Label
    private let items: [NBMenuItem]

    /// Creates a menu.
    /// - Parameters:
    ///   - items: A builder providing the dropdown's `NBMenuItem`s.
    ///   - label: The content of the trigger button (a trailing chevron is added automatically).
    public init(
        @NBMenuBuilder items: () -> [NBMenuItem],
        @ViewBuilder label: () -> Label
    ) {
        self.items = items()
        self.label = label()
    }

    public var body: some View {
        Button {
            isOpen.toggle()
        } label: {
            HStack(spacing: theme.smspacing) {
                label
                Image(systemName: "chevron.down")
                    .font(.caption.bold())
                    .rotationEffect(.degrees(isOpen ? 180 : 0))
            }
        }
        .buttonStyle(.neoBrutalism(type: .neutral))
        .background {
            GeometryReader { proxy in
                Color.clear
                    .onAppear { triggerFrame = proxy.frame(in: .global) }
                    .onChange(of: proxy.frame(in: .global)) { _, newValue in
                        triggerFrame = newValue
                        // The trigger moved (e.g. the screen scrolled) — the dropdown's
                        // anchor is now stale, so close it rather than leave it floating.
                        if isOpen { isOpen = false }
                    }
            }
        }
        .onChange(of: isOpen) { _, newValue in
            if newValue {
                presentOverlay()
            }
        }
        .onDisappear { overlayWindow.hide() }
    }

    private func presentOverlay() {
        overlayWindow.show {
            NBMenuOverlayContent(
                theme: theme,
                colorScheme: colorScheme,
                reduceMotion: reduceMotion,
                triggerFrame: triggerFrame,
                items: items,
                onDismiss: { [overlayWindow] in
                    isOpen = false
                    overlayWindow.hide()
                }
            )
        }
    }
}

/// The content hosted inside `NBOverlayWindow`: a full-screen tap-to-dismiss catcher plus the
/// themed dropdown, positioned under the trigger using its frame in the original window.
private struct NBMenuOverlayContent: View {
    let theme: NBTheme
    let colorScheme: ColorScheme
    let reduceMotion: Bool
    let triggerFrame: CGRect
    let items: [NBMenuItem]
    let onDismiss: () -> Void

    @State private var appear = false
    @State private var dropdownSize: CGSize = .zero
    /// The items' *natural* (uncapped) height, measured independently of `dropdownSize` so the
    /// scroll-cap decision can't feed back on the size it's derived from.
    @State private var contentHeight: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            let placement = placement(in: proxy.size)

            ZStack(alignment: .topLeading) {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture { dismiss() }

                dropdown(elevated: appear)
                    .background {
                        GeometryReader { dropdownProxy in
                            Color.clear
                                .onAppear { setDropdownSize(dropdownProxy.size) }
                                .onChange(of: dropdownProxy.size) { _, newValue in setDropdownSize(newValue) }
                        }
                    }
                    // Scale before offset, not after: `scaleEffect`'s anchor math treats
                    // whatever comes before it in the chain as part of what's being scaled, so
                    // scaling after offsetting would shrink the offset itself toward the
                    // ZStack's origin — pulling the dropdown toward the top-left of the screen
                    // instead of collapsing around `anchor`. Scaling first keeps the anchor
                    // pinned in local space; the offset then moves the already-scaled box.
                    .scaleEffect(appear ? 1 : 0.85, anchor: placement.anchor)
                    .offset(x: placement.x, y: placement.y)
                    // Tied to `appear` (not just the measurement gate) so dismissal fades the
                    // dropdown out in step with its shrink — by the time the overlay window is
                    // torn down after the animation, there's nothing visible left to "pop off".
                    // `appear` only flips true post-measurement, so this still stays hidden
                    // until the flip/clamp math has real numbers to work with.
                    .opacity(appear ? 1 : 0)
            }
        }
        .ignoresSafeArea()
        .environment(\.nbTheme, theme)
        .colorScheme(colorScheme)
    }

    /// Records the dropdown's measured size, then — only the first time, once real numbers are
    /// available for the flip/clamp math — kicks off the open spring. Starting the animation any
    /// earlier races this measurement: the resulting mid-flight re-render forces SwiftUI to
    /// reconcile the in-flight spring, which is what caused the visible hitch/pause partway
    /// through the animation.
    private func setDropdownSize(_ size: CGSize) {
        let wasUnmeasured = dropdownSize == .zero
        dropdownSize = size
        if wasUnmeasured {
            withAnimation(nbPopAnimation(reduceMotion: reduceMotion)) {
                appear = true
            }
        }
    }

    /// Positions the dropdown under the trigger by default, but flips it above the trigger when
    /// there isn't enough room below (e.g. the trigger sits near the bottom of the screen), and
    /// clamps both axes so it's never cut off by any screen edge.
    private func placement(in screenSize: CGSize) -> (x: CGFloat, y: CGFloat, anchor: UnitPoint) {
        let spacing = theme.smspacing
        let spaceBelow = screenSize.height - triggerFrame.maxY
        let spaceAbove = triggerFrame.minY

        let opensUpward = dropdownSize.height + spacing > spaceBelow && spaceAbove > spaceBelow

        let rawY = opensUpward
            ? triggerFrame.minY - spacing - dropdownSize.height
            : triggerFrame.maxY + spacing
        let anchor: UnitPoint = opensUpward ? .bottom : .top

        let minY = spacing
        let maxY = max(minY, screenSize.height - dropdownSize.height - spacing)
        let y = min(max(rawY, minY), maxY)

        let minX = spacing
        let maxX = max(minX, screenSize.width - dropdownSize.width - spacing)
        let x = min(max(triggerFrame.minX, minX), maxX)

        return (x, y, anchor)
    }

    /// - Parameter elevated: Whether the box's hard drop shadow is popped out (open) or
    ///   collapsed flush against the surface (closed) — the same shadow-collapse language
    ///   `nbPressEffect` uses for a pressed button.
    private func dropdown(elevated: Bool) -> some View {
        let screenHeight = UIScreen.main.bounds.height
        let scrollCap = screenHeight * 0.6
        // Decide from the items' natural height, NOT `dropdownSize`: `dropdownSize` measures the
        // final (possibly capped) container, so deriving `needsScroll` from it would oscillate —
        // capping shrinks the measured height back under the cap, which un-caps, which re-grows…
        let needsScroll = contentHeight > scrollCap

        let itemsView = VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                if item.kind == .divider {
                    Rectangle()
                        .fill(theme.border)
                        .frame(height: theme.borderWidth * 2)
                        .padding(.vertical, theme.smpadding)
                } else {
                    Button {
                        dismiss()
                        item.action()
                    } label: {
                        item.label
                            .foregroundStyle(item.role == .destructive ? theme.destructive : theme.text)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(theme.padding)
                            .opacity(item.disabled ? 0.5 : 1)
                    }
                    .buttonStyle(NBMenuItemButtonStyle())
                    .disabled(item.disabled)

                    // Hairline separator between items, but skip if next item is a divider
                    if index < items.count - 1 && items[index + 1].kind != .divider {
                        Rectangle()
                            .fill(theme.border)
                            .frame(height: theme.borderWidth)
                    }
                }
            }
        }
        .frame(minWidth: triggerFrame.width, alignment: .leading)
        .fixedSize(horizontal: true, vertical: true)
        .background {
            // Measures the items' natural height (kept natural by `.fixedSize` even inside the
            // ScrollView below), feeding the stable `needsScroll` decision above.
            GeometryReader { proxy in
                Color.clear
                    .onAppear { contentHeight = proxy.size.height }
                    .onChange(of: proxy.size.height) { _, newValue in contentHeight = newValue }
            }
        }

        if needsScroll {
            return AnyView(
                ScrollView {
                    itemsView
                }
                .frame(maxHeight: scrollCap)
                .frame(minWidth: triggerFrame.width, alignment: .leading)
                .nbBox(elevated: elevated)
            )
        } else {
            return AnyView(
                itemsView
                    .nbBox(elevated: elevated)
            )
        }
    }

    private func dismiss() {
        withAnimation(nbPressAnimation(reduceMotion: reduceMotion)) {
            appear = false
        }
        let delay = reduceMotion ? 0 : 0.25
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            onDismiss()
        }
    }
}

/// A single row in an ``NBMenu``.
public struct NBMenuItem: Identifiable {
    enum Kind {
        case item
        case divider
    }

    public let id: UUID
    let label: AnyView
    let role: ButtonRole?
    let action: () -> Void
    let disabled: Bool
    let kind: Kind

    /// Creates a menu item from a title and optional SF Symbol.
    /// - Parameters:
    ///   - title: The row's text.
    ///   - systemImage: An optional leading SF Symbol name.
    ///   - role: An optional role; `.destructive` renders the row in red.
    ///   - disabled: Whether this item is disabled and non-interactive.
    ///   - action: The closure run when the row is tapped.
    public init(
        _ title: String,
        systemImage: String? = nil,
        role: ButtonRole? = nil,
        disabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.id = UUID()
        if let systemImage {
            self.label = AnyView(Label(title, systemImage: systemImage))
        } else {
            self.label = AnyView(Text(title))
        }
        self.role = role
        self.disabled = disabled
        self.action = action
        self.kind = .item
    }

    /// Creates a menu item with fully custom label content.
    /// - Parameters:
    ///   - role: An optional role; `.destructive` renders the row in red.
    ///   - disabled: Whether this item is disabled and non-interactive.
    ///   - action: The closure run when the row is tapped.
    ///   - label: The row's content.
    public init<Content: View>(
        role: ButtonRole? = nil,
        disabled: Bool = false,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Content
    ) {
        self.id = UUID()
        self.label = AnyView(label())
        self.role = role
        self.disabled = disabled
        self.action = action
        self.kind = .item
    }

    /// A section divider row.
    private init(divider: Void) {
        self.id = UUID()
        self.label = AnyView(EmptyView())
        self.role = nil
        self.disabled = true
        self.action = {}
        self.kind = .divider
    }
}

public extension NBMenuItem {
    /// A section divider row.
    static var divider: NBMenuItem {
        NBMenuItem(divider: ())
    }
}

/// Result builder for assembling ``NBMenuItem`` rows.
@resultBuilder
public struct NBMenuBuilder {
    public static func buildBlock(_ components: [NBMenuItem]...) -> [NBMenuItem] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: NBMenuItem) -> [NBMenuItem] {
        [expression]
    }

    public static func buildArray(_ components: [[NBMenuItem]]) -> [NBMenuItem] {
        components.flatMap { $0 }
    }

    public static func buildOptional(_ component: [NBMenuItem]?) -> [NBMenuItem] {
        component ?? []
    }

    public static func buildEither(first component: [NBMenuItem]) -> [NBMenuItem] {
        component
    }

    public static func buildEither(second component: [NBMenuItem]) -> [NBMenuItem] {
        component
    }
}

/// Highlights a menu row with the theme's main color while pressed.
private struct NBMenuItemButtonStyle: ButtonStyle {
    @Environment(\.nbTheme) private var theme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? theme.main : theme.bw)
            .contentShape(Rectangle())
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(alignment: .leading, spacing: 20) {
        NBMenu {
            NBMenuItem("Edit", systemImage: "pencil") {}
            NBMenuItem("Duplicate", systemImage: "plus.square.on.square") {}
            NBMenuItem.divider
            NBMenuItem("Share", systemImage: "square.and.arrow.up", disabled: true) {}
            NBMenuItem("Delete", systemImage: "trash", role: .destructive) {}
        } label: {
            Text("Options")
        }

        NBMenu {
            NBMenuItem("Holly & Phoenix Feather") {}
            NBMenuItem("Elder & Thestral Hair") {}
            NBMenuItem("Vine & Dragon Heartstring") {}
        } label: {
            Label("Choose Your Wand", systemImage: "wand.and.stars")
        }
    }
    .padding()
}

/// Demonstrates the dropdown flipping upward when the trigger sits near the bottom of the
/// screen, so the menu stays fully visible instead of running off the bottom edge.
@available(iOS 18.0, *)
#Preview("Bottom-anchored trigger", traits: .modifier(NBPreviewHelper())) {
    VStack {
        Spacer()
        HStack {
            Spacer()
            NBMenu {
                NBMenuItem("Edit", systemImage: "pencil") {}
                NBMenuItem("Duplicate", systemImage: "plus.square.on.square") {}
                NBMenuItem("Share", systemImage: "square.and.arrow.up") {}
                NBMenuItem("Delete", systemImage: "trash", role: .destructive) {}
            } label: {
                Text("Options")
            }
            Spacer()
        }
    }
    .padding(.bottom, 40)
}

/// Demonstrates a long menu that scrolls when it exceeds 60% of screen height.
@available(iOS 18.0, *)
#Preview("Long scrollable menu", traits: .modifier(NBPreviewHelper())) {
    VStack(alignment: .leading, spacing: 20) {
        NBMenu {
            NBMenuItem("Item 1", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 2", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 3", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 4", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 5", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 6", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 7", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 8", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 9", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 10", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 11", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 12", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 13", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 14", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 15", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 16", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 17", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 18", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 19", systemImage: "square.and.pencil") {}
            NBMenuItem("Item 20", systemImage: "square.and.pencil") {}
        } label: {
            Text("Scroll Menu")
        }
    }
    .padding()
}
