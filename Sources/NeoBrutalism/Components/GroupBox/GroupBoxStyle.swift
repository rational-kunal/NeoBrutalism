import SwiftUI

public extension GroupBoxStyle where Self == NBGroupBoxStyle {
    static func neoBrutalism(
        type: NBGroupBoxStyle.GroupBoxType = .default,
        elevated: Bool = true
    ) -> NBGroupBoxStyle {
        .init(type: type, elevated: elevated)
    }
}

/// A neo-brutalism card style for the native `GroupBox`.
///
/// The group box label renders as a bold header above the content, on a themed
/// surface wrapped in the signature `.nbBox()` border and hard drop shadow.
///
/// ```swift
/// GroupBox("Hogwarts Letter") {
///     Text("You have been accepted!")
/// }
/// .groupBoxStyle(.neoBrutalism())
/// ```
///
/// Pass `elevated: false` for a flat card: the drop shadow is removed and the
/// tighter default padding is used. Elevated cards use the theme's `xlpadding`.
public struct NBGroupBoxStyle: GroupBoxStyle {
    /// The group box's fill: `.default` uses the theme's `main` color, `.neutral` uses `bw`.
    public enum GroupBoxType {
        case `default`, neutral
    }

    @Environment(\.nbTheme) var theme: NBTheme

    let type: GroupBoxType
    let elevated: Bool

    init(type: GroupBoxType = .default, elevated: Bool = true) {
        self.type = type
        self.elevated = elevated
    }

    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing) {
            configuration.label
                .bold()

            configuration.content
        }
        .foregroundStyle(textForegroundColor)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(elevated ? theme.xlpadding : theme.padding)
        .background(backgroundColor)
        .nbBox(elevated: elevated)
    }

    private var textForegroundColor: Color {
        switch type {
        case .default:
            theme.mainText
        case .neutral:
            theme.text
        }
    }

    private var backgroundColor: Color {
        switch type {
        case .default:
            theme.main
        case .neutral:
            theme.bw
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(spacing: 24.0) {
        GroupBox("Header") {
            Text("Main")
        }
        .groupBoxStyle(.neoBrutalism())

        GroupBox("Header") {
            Text("Main")
        }
        .groupBoxStyle(.neoBrutalism(type: .neutral))

        GroupBox {
            Text("Flat, no label")
        }
        .groupBoxStyle(.neoBrutalism(elevated: false))

        GroupBox("Flat neutral") {
            Text("Main")
        }
        .groupBoxStyle(.neoBrutalism(type: .neutral, elevated: false))
    }
}
