import SwiftUI

public extension GroupBoxStyle where Self == NBGroupBoxStyle {
    static func neoBrutalism(type: NBGroupBoxStyle.GroupBoxType = .default, elevated: Bool = true) -> NBGroupBoxStyle {
        .init(type: type, elevated: elevated)
    }
}

public struct NBGroupBoxStyle: GroupBoxStyle {
    public enum GroupBoxType {
        case `default`, neutral
    }

    @Environment(\.nbTheme) private var theme

    let type: GroupBoxType
    let elevated: Bool

    public init(type: GroupBoxType = .default, elevated: Bool = true) {
        self.type = type
        self.elevated = elevated
    }

    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing) {
            configuration.label
                .foregroundStyle(textForegroundColor)
                .bold()

            configuration.content
                .foregroundStyle(textForegroundColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(theme.xlpadding)
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
    VStack(spacing: 24) {
        GroupBox("Profile") {
            VStack(alignment: .leading) {
                Text("Name: Jane Doe")
                Text("Membership: Pro")
            }
        }
        .groupBoxStyle(.neoBrutalism())

        GroupBox("Settings") {
            VStack(alignment: .leading) {
                Toggle(isOn: .constant(true)) { Text("Notifications") }
                Toggle(isOn: .constant(false)) { Text("Auto-Update") }
            }
        }
        .groupBoxStyle(.neoBrutalism(type: .neutral, elevated: false))
    }
    .padding()
}


