import SwiftUI

extension EnvironmentValues {
    @Entry var neoBrutalismTheme: Theme = .default
}

extension View {
    func neoBrutalism(theme: Theme) -> some View {
        environment(\.neoBrutalismTheme, theme)
    }
}

struct Theme {
    // MARK: Color

    var main: Color

    /* white and secondary black - main color when the UI element should be emphasised */
    var bw: Color

    var overlay: Color

    var background: Color

    var blank: Color

    var border: Color

    var text: Color

    /* text that is placed on background with main color */
    var mainText: Color

    var clear: Color = .clear

    // MARK: Spacings

    /* Usually is a vertical size */
    var size: CGFloat
    var ssize: CGFloat

    var padding: CGFloat

    var spacing: CGFloat
    var xlspacing: CGFloat

    var borderWidth: CGFloat

    var borderRadius: CGFloat

    var boxShadowX: CGFloat

    var boxShadowY: CGFloat

    // MARK: Themes

    static let `default`: Theme = .init(
        main: Color(
            light: .rgb(0.533, 0.667, 0.933),
            dark: .rgb(0.533, 0.667, 0.933)
        ),
        bw: Color(
            light: .rgb(1.0, 1.0, 1.0),
            dark: .rgb(0.129, 0.129, 0.129)
        ),
        overlay: Color(
            light: .rgba(0.0, 0.0, 0.0, 0.6),
            dark: .rgba(0.0, 0.0, 0.0, 0.6)
        ),
        background: Color(
            light: .rgb(0.875, 0.898, 0.949),
            dark: .rgb(0.153, 0.161, 0.2)
        ),
        blank: Color(
            light: .rgb(1.0, 1.0, 1.0),
            dark: .rgb(1.0, 1.0, 1.0)
        ),
        border: Color(
            light: .rgb(0.0, 0.0, 0.0),
            dark: .rgb(0.0, 0.0, 0.0)
        ),
        text: Color(
            light: .rgb(0.0, 0.0, 0.0),
            dark: .rgb(0.902, 0.902, 0.902)
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0),
            dark: .rgb(0.0, 0.0, 0.0)
        ),
        size: 16.0, ssize: 8.0,
        padding: 12.0,
        spacing: 12.0, xlspacing: 24.0,
        borderWidth: 2.0, borderRadius: 5.0,
        boxShadowX: 4.0, boxShadowY: 4.0
    )
}

extension UIColor {
    convenience init(
        light lightColor: @escaping @autoclosure () -> UIColor,
        dark darkColor: @escaping @autoclosure () -> UIColor
    ) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return lightColor()
            case .dark:
                return darkColor()
            case .unspecified:
                return lightColor()
            @unknown default:
                return lightColor()
            }
        }
    }

    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return .rgba(red, green, blue, 1.0)
    }

    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return .init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Color {
    init(
        light lightColor: @escaping @autoclosure () -> UIColor,
        dark darkColor: @escaping @autoclosure () -> UIColor
    ) {
        self.init(UIColor(light: lightColor(), dark: darkColor()))
    }
}
