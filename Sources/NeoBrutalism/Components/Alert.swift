import SwiftUI

/// An inline, non-dismissible callout box for a title, message, and optional icon — the
/// bordered `nbBox()` treatment applied to a banner rather than a full-screen dialog.
///
/// Prefer the string-based convenience initializers below unless you need custom
/// `View` content for the icon, title, or message.
///
/// ```swift
/// NBAlert("Warning", message: "The Chamber has been opened.",
///         systemImage: "exclamationmark.triangle")
/// ```
public struct NBAlert<Icon, Head, Desc>: View where Icon: View, Head: View, Desc: View {
    /// The alert's fill: `.default` uses the theme's `main` color, `.neutral` uses `bw`.
    public enum AlertType {
        case `default`, neutral
    }

    @Environment(\.nbTheme) var theme: NBTheme

    private let type: AlertType

    private let desc: Desc
    private let icon: Icon
    private let head: Head

    private var textForegroundColor: Color {
        switch type {
        case .default:
            return theme.mainText
        case .neutral:
            return theme.text
        }
    }

    /// Creates an alert from fully custom `View` content.
    /// - Parameters:
    ///   - type: The alert type (default or neutral). Defaults to `.default`.
    ///   - desc: The alert's message content.
    ///   - icon: The alert's leading icon content. Defaults to no icon.
    ///   - head: The alert's title content.
    public init(
        type: AlertType = .default, @ViewBuilder desc: () -> Desc,
        @ViewBuilder icon: () -> Icon = { EmptyView() }, @ViewBuilder head: () -> Head
    ) {
        self.type = type
        self.head = head()
        self.icon = icon()
        self.desc = desc()
    }

    public var body: some View {
        ZStack {
            HStack(alignment: .top) {
                iconWrappedView

                VStack(alignment: .leading) {
                    head
                        .bold()
                    desc
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(theme.padding)
        .foregroundStyle(textForegroundColor)
        .background(backgroundColor)
        .nbBox()
    }
}

extension NBAlert {
    var iconWrappedView: some View {
        icon
            .frame(minWidth: theme.size)
            .foregroundStyle(textForegroundColor)
            .padding(.top, 1.0)
    }

    var backgroundColor: Color {
        switch type {
        case .default:
            theme.main
        case .neutral:
            theme.bw
        }
    }
}

public extension NBAlert where Icon == Image, Head == Text, Desc == Text {
    /// Creates an alert from a title, message, and SF Symbol.
    ///
    /// - Parameters:
    ///   - title: The alert's title.
    ///   - message: The alert's message text.
    ///   - systemImage: The name of the SF Symbol to display as the icon.
    ///   - type: The alert type (default or neutral). Defaults to `.default`.
    ///
    /// Example:
    /// ```swift
    /// NBAlert("Warning", message: "The Chamber has been opened.",
    ///         systemImage: "exclamationmark.triangle")
    /// ```
    init(_ title: LocalizedStringKey, message: LocalizedStringKey,
         systemImage: String, type: AlertType = .default) {
        self.init(type: type, desc: { Text(message) }, icon: { Image(systemName: systemImage) }, head: { Text(title) })
    }
}

public extension NBAlert where Icon == EmptyView, Head == Text, Desc == Text {
    /// Creates an alert from a title and message, without an icon.
    ///
    /// - Parameters:
    ///   - title: The alert's title.
    ///   - message: The alert's message text.
    ///   - type: The alert type (default or neutral). Defaults to `.default`.
    init(_ title: LocalizedStringKey, message: LocalizedStringKey,
         type: AlertType = .default) {
        self.init(type: type, desc: { Text(message) }, head: { Text(title) })
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(spacing: 18.0) {
        // String-based convenience initializers
        NBAlert("Alert", message: "Desc")

        NBAlert("Warning", message: "The Chamber has been opened.",
                systemImage: "exclamationmark.triangle")

        NBAlert("Neutral", message: "This is neutral.", type: .neutral)

        // Builder form (showing it still exists)
        NBAlert(type: .neutral) {
            Text("Builder form allows any View types for title, message, or icon")
        } icon: {
            Image(systemName: "questionmark")
        } head: {
            Text("Flexible")
        }
    }
}
