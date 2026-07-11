import SwiftUI

public extension EnvironmentValues {
    /// The `NBTheme` active in this part of the view hierarchy. Defaults to ``NBTheme/default``;
    /// override it for a subtree with `View.nbTheme(_:)`.
    @Entry var nbTheme: NBTheme = .default
}

public extension View {
    /// Injects an `NBTheme` into the environment, so every NeoBrutalism component
    /// beneath this view reads its colors and metrics from `theme` instead of `.default`.
    ///
    /// ```swift
    /// ContentView()
    ///     .nbTheme(.default.updateBy(main: .orange, borderWidth: 3))
    /// ```
    func nbTheme(_ theme: NBTheme) -> some View {
        environment(\.nbTheme, theme)
    }
}

/// The design tokens that drive every NeoBrutalism component: colors, spacing, and the
/// border/shadow values that give the style its signature hard-edged, offset-shadow look.
///
/// The token set is inspired by the reference styling at
/// [neobrutalism.dev/styling](https://www.neobrutalism.dev/styling), adapted to SwiftUI so
/// components read tokens from the environment instead of hardcoding values.
///
/// Read the active theme with `@Environment(\.nbTheme)`, override it for a subtree with
/// `View.nbTheme(_:)`, and derive a variant of an existing theme with `NBTheme.updateBy(...)`.
///
/// ```swift
/// struct MyView: View {
///     @Environment(\.nbTheme) private var theme
///
///     var body: some View {
///         Text("Hello")
///             .padding(theme.padding)
///             .background(theme.main)
///             .foregroundStyle(theme.mainText)
///     }
/// }
/// ```
public struct NBTheme: Sendable {
    // MARK: Color

    /// The brand/accent color, used as the default fill for emphasised elements such as
    /// primary buttons and active states.
    public private(set) var main: Color

    /// The base surface color for bordered UI elements (cards, inputs, buttons): white in
    /// light mode, near-black in dark mode.
    public private(set) var bw: Color

    /// The scrim color drawn behind modals, sheets, and dialogs.
    public private(set) var overlay: Color

    /// The page/screen background color, distinct from `bw` so bordered elements stand out
    /// against it.
    public private(set) var background: Color

    /// A plain white used where a surface must stay white regardless of light/dark mode
    /// (e.g. content sitting on top of `main`).
    public private(set) var blank: Color

    /// The color of the thick borders that outline every NeoBrutalism element; always black
    /// in both light and dark mode by default.
    public private(set) var border: Color

    /// The default foreground color for body text and icons.
    public private(set) var text: Color

    /// The foreground color used for text/icons placed on top of the `main` color, so it
    /// stays legible regardless of theme.
    public private(set) var mainText: Color

    /// A fully transparent color, provided for convenience when a token slot is required
    /// but no fill should be drawn.
    public private(set) var clear: Color = .clear

    // MARK: Spacings

    /// The smallest step in the size scale (icon/control sizing), typically used for compact
    /// components. Usually a vertical dimension.
    public private(set) var smsize: CGFloat
    /// The default step in the size scale.
    public private(set) var size: CGFloat
    /// The largest step in the size scale, for prominent controls.
    public private(set) var xlsize: CGFloat

    /// The smallest step in the padding scale.
    public private(set) var smpadding: CGFloat
    /// The default step in the padding scale.
    public private(set) var padding: CGFloat
    /// The largest step in the padding scale.
    public private(set) var xlpadding: CGFloat

    /// The smallest step in the spacing scale (gaps between sibling elements).
    public private(set) var smspacing: CGFloat
    /// The default step in the spacing scale.
    public private(set) var spacing: CGFloat
    /// The largest step in the spacing scale.
    public private(set) var xlspacing: CGFloat

    /// The stroke width of the border drawn around NeoBrutalism elements.
    public private(set) var borderWidth: CGFloat

    /// The corner radius applied to bordered NeoBrutalism elements.
    public private(set) var borderRadius: CGFloat

    /// The horizontal offset of the hard drop shadow characteristic of the style.
    public private(set) var boxShadowX: CGFloat

    /// The vertical offset of the hard drop shadow characteristic of the style.
    public private(set) var boxShadowY: CGFloat

    // MARK: Themes

    /// The default NeoBrutalism theme: a light-blue `main` accent, black borders, and the
    /// standard spacing/shadow scale, with matching light and dark mode color pairs.
    public static let `default`: NBTheme = .init(
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

    /// Returns a copy of this theme with only the given tokens overridden, leaving every
    /// unspecified parameter unchanged. Use this to derive a variant of `.default` (or any
    /// other theme) without restating every token.
    ///
    /// ```swift
    /// let danger = NBTheme.default.updateBy(main: .red, mainText: .white)
    /// ```
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
    ) -> NBTheme {
        return NBTheme(
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
