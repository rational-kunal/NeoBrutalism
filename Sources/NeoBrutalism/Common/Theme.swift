import SwiftUI

public extension EnvironmentValues {
    @Entry var neoBrutalismTheme: Theme = .default
}

public extension View {
    func neoBrutalism(theme: Theme) -> some View {
        environment(\.neoBrutalismTheme, theme)
    }
}

public struct Theme: Sendable {
    // MARK: Color

    public private(set) var main: Color

    /* white and secondary black - main color when the UI element should be emphasised */
    public private(set) var bw: Color

    public private(set) var overlay: Color

    public private(set) var background: Color

    public private(set) var blank: Color

    public private(set) var border: Color

    public private(set) var text: Color

    /* text that is placed on background with main color */
    public private(set) var mainText: Color

    public private(set) var clear: Color = .clear

    // MARK: Spacings

    /* Usually is a vertical size */
    public private(set) var smsize: CGFloat
    public private(set) var size: CGFloat
    public private(set) var xlsize: CGFloat

    public private(set) var smpadding: CGFloat
    public private(set) var padding: CGFloat
    public private(set) var xlpadding: CGFloat

    public private(set) var smspacing: CGFloat
    public private(set) var spacing: CGFloat
    public private(set) var xlspacing: CGFloat

    public private(set) var borderWidth: CGFloat

    public private(set) var borderRadius: CGFloat

    public private(set) var boxShadowX: CGFloat

    public private(set) var boxShadowY: CGFloat

    // MARK: Themes

    public static let `default`: Theme = .init(
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
        smsize: 8.0, size: 16.0, xlsize: 24.0,
        smpadding: 8.0, padding: 12.0, xlpadding: 24.0,
        smspacing: 8.0, spacing: 12.0, xlspacing: 24.0,
        borderWidth: 2.0, borderRadius: 5.0,
        boxShadowX: 4.0, boxShadowY: 4.0
    )

    public func updateBy(
        main: Color? = nil,
        bw: Color? = nil,
        overlay: Color? = nil,
        background: Color? = nil,
        blank: Color? = nil,
        border: Color? = nil,
        text: Color? = nil,
        mainText: Color? = nil,
        smsize: CGFloat? = nil,
        size: CGFloat? = nil,
        xlsize: CGFloat? = nil,
        smpadding: CGFloat? = nil,
        padding: CGFloat? = nil,
        xlpadding: CGFloat? = nil,
        smspacing: CGFloat? = nil,
        spacing: CGFloat? = nil,
        xlspacing: CGFloat? = nil,
        borderWidth: CGFloat? = nil,
        borderRadius: CGFloat? = nil,
        boxShadowX: CGFloat? = nil,
        boxShadowY: CGFloat? = nil
    ) -> Theme {
        return Theme(
            main: main ?? self.main,
            bw: bw ?? self.bw,
            overlay: overlay ?? self.overlay,
            background: background ?? self.background,
            blank: blank ?? self.blank,
            border: border ?? self.border,
            text: text ?? self.text,
            mainText: mainText ?? self.mainText,
            smsize: smsize ?? self.smsize,
            size: size ?? self.size,
            xlsize: xlsize ?? self.xlsize,
            smpadding: smpadding ?? self.smpadding,
            padding: padding ?? self.padding,
            xlpadding: xlpadding ?? self.xlpadding,
            smspacing: smspacing ?? self.smspacing,
            spacing: spacing ?? self.spacing,
            xlspacing: xlspacing ?? self.xlspacing,
            borderWidth: borderWidth ?? self.borderWidth,
            borderRadius: borderRadius ?? self.borderRadius,
            boxShadowX: boxShadowX ?? self.boxShadowX,
            boxShadowY: boxShadowY ?? self.boxShadowY
        )
    }
}

public extension UIColor {
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

public extension Color {
    init(
        light lightColor: @escaping @autoclosure () -> UIColor,
        dark darkColor: @escaping @autoclosure () -> UIColor
    ) {
        self.init(UIColor(light: lightColor(), dark: darkColor()))
    }
}
