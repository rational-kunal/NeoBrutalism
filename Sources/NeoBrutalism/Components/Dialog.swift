import SwiftUI

/// Presents a centered neobrutalism dialog over a scrim — a themed replacement for
/// `alert(_:isPresented:actions:message:)`.
///
/// ```swift
/// .nbDialog("Delete spell?", isPresented: $confirming) {
///     Button("Delete", role: .destructive) { delete() }
///     Button("Keep") { }
/// } message: {
///     Text("This cannot be undone.")
/// }
/// ```
///
/// The dialog animates in with a pop effect and collapses when dismissed, respecting
/// Reduce Motion settings. Tapping the scrim dismisses the dialog; actions must call
/// your binding manually (just like SwiftUI's `alert` does). To apply destructive
/// styling to a button, pass `.buttonStyle(.neoBrutalism(type: .neutral))` with a
/// red-tinted theme, or document the limitation for your consumers.
public extension View {
    func nbDialog<Actions: View, Message: View>(
        _ title: LocalizedStringKey,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder message: @escaping () -> Message
    ) -> some View {
        modifier(
            NBDialogModifier(
                isPresented: isPresented,
                title: title,
                actions: { AnyView(actions()) },
                message: { AnyView(message()) }
            )
        )
    }
}

// MARK: -

private struct NBDialogModifier: ViewModifier {
    let isPresented: Binding<Bool>
    let title: LocalizedStringKey
    let actions: () -> AnyView
    let message: () -> AnyView

    @Environment(\.nbTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var overlayWindow = NBOverlayWindow()

    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented.wrappedValue) { _, newValue in
                if newValue {
                    presentOverlay()
                } else {
                    // The binding went false — either the scrim-tap path (which already
                    // animated the card collapse before flipping it) or a consumer flipping
                    // it in their action. Either way, tear the overlay window down.
                    overlayWindow.hide()
                }
            }
            .onDisappear { overlayWindow.hide() }
    }

    private func presentOverlay() {
        overlayWindow.show {
            NBDialogOverlayContent(
                theme: theme,
                colorScheme: colorScheme,
                reduceMotion: reduceMotion,
                title: title,
                actions: actions(),
                message: message(),
                isPresented: isPresented
            )
        }
    }
}

// MARK: -

private struct NBDialogOverlayContent: View {
    let theme: NBTheme
    let colorScheme: ColorScheme
    let reduceMotion: Bool
    let title: LocalizedStringKey
    let actions: AnyView
    let message: AnyView
    let isPresented: Binding<Bool>

    @State private var appear = false

    var body: some View {
        GeometryReader { _ in
            ZStack {
                // Scrim: full-screen tap-to-dismiss
                theme.overlay
                    .contentShape(Rectangle())
                    .onTapGesture { dismiss() }
                    .accessibilityLabel("Dismiss")
                    .accessibilityAction { dismiss() }

                // Card: centered dialog
                VStack(spacing: theme.spacing) {
                    Text(title)
                        .font(.body.bold())
                        .foregroundStyle(theme.text)

                    message
                        .font(.body)
                        .foregroundStyle(theme.text)

                    actions
                        .buttonStyle(.neoBrutalism())
                        .frame(maxWidth: .infinity)
                }
                .padding(theme.xlpadding)
                .background(theme.bw)
                .nbBox()
                .frame(maxWidth: 320)
                .accessibilityAddTraits(.isModal)
                .scaleEffect(appear ? 1 : 0.85, anchor: .center)
                .opacity(appear ? 1 : 0)
            }
        }
        .ignoresSafeArea()
        .environment(\.nbTheme, theme)
        .colorScheme(colorScheme)
        .onAppear {
            withAnimation(nbPopAnimation(reduceMotion: reduceMotion)) {
                appear = true
            }
        }
    }

    private func dismiss() {
        withAnimation(nbPressAnimation(reduceMotion: reduceMotion)) {
            appear = false
        }
        let delay = reduceMotion ? 0 : 0.25
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            isPresented.wrappedValue = false
        }
    }
}

// MARK: -

/// The card component of the dialog, extracted as an internal view for snapshotting.
/// This view renders the card alone without the window machinery or scrim.
struct NBDialogCard: View {
    let title: LocalizedStringKey
    let message: AnyView
    let actions: AnyView

    @Environment(\.nbTheme) private var theme

    var body: some View {
        VStack(spacing: theme.spacing) {
            Text(title)
                .font(.body.bold())
                .foregroundStyle(theme.text)

            message
                .font(.body)
                .foregroundStyle(theme.text)

            actions
                .buttonStyle(.neoBrutalism())
                .frame(maxWidth: .infinity)
        }
        .padding(theme.xlpadding)
        .background(theme.bw)
        .nbBox()
        .frame(maxWidth: 320)
        .accessibilityAddTraits(.isModal)
    }
}
