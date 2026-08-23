import SwiftUI

/// Which corners of an `nbBox()` should be rounded; the rest render square.
///
/// Used for elements that join edge-to-edge with a neighbor (e.g. `NBControlGroupStyle`'s
/// middle sections, or the first/last row of a boxed list), where only the outer corners of
/// the joined group should round.
///
/// ```swift
/// Text("Right-rounded only")
///     .nbBox(roundedCorners: .right)
/// ```
public struct NBCornerSet: OptionSet, Sendable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let topLeft = Self(rawValue: 1 << 0)
    public static let topRight = Self(rawValue: 1 << 1)
    public static let bottomLeft = Self(rawValue: 1 << 2)
    public static let bottomRight = Self(rawValue: 1 << 3)

    public static let top: Self = [.topLeft, .topRight]
    public static let bottom: Self = [.bottomLeft, .bottomRight]
    public static let left: Self = [.topLeft, .bottomLeft]
    public static let right: Self = [.topRight, .bottomRight]

    /// Every corner rounded — the default for a standalone box.
    public static let all: Self = [.top, .bottom]
}

struct NBBoxModifier: ViewModifier {
    @Environment(\.nbTheme) var theme: NBTheme

    let elevated: Bool
    let roundedCorners: NBCornerSet

    func body(content: Content) -> some View {
        let radius = theme.borderRadius

        let shape = UnevenRoundedRectangle(
            topLeadingRadius: roundedCorners.contains(.topLeft) ? radius : 0,
            bottomLeadingRadius: roundedCorners.contains(.bottomLeft) ? radius : 0,
            bottomTrailingRadius: roundedCorners.contains(.bottomRight) ? radius : 0,
            topTrailingRadius: roundedCorners.contains(.topRight) ? radius : 0
        )

        content
            // Content that paints its own square-cornered background (e.g. a row inside a
            // menu or segmented picker) would otherwise poke out past the rounded corner,
            // showing as a stray square speck outside the border stroke.
            .clipShape(shape)
            .background {
                shape
                    .fill(theme.bw)
                    .shadow(
                        color: theme.border,
                        radius: 0,
                        x: elevated ? theme.boxShadowX : 0,
                        y: elevated ? theme.boxShadowY : 0
                    )
            }
            .overlay {
                shape
                    .stroke(theme.border, lineWidth: theme.borderWidth)
            }
    }
}

public extension View {
    /// Wraps this view in the signature neobrutalism surface: a themed background, a thick
    /// black border, and — when `elevated` — a hard offset drop shadow. This is the building
    /// block every bordered NeoBrutalism component (buttons, cards, inputs, badges…) is built
    /// on top of.
    ///
    /// ```swift
    /// Text("Harry Potter")
    ///     .padding(8.0)
    ///     .nbBox()
    /// ```
    ///
    /// - Parameters:
    ///   - elevated: Whether to draw the hard drop shadow. Pass `false` for a flat surface
    ///     (e.g. a pressed state, or a nested/secondary surface). Defaults to `true`.
    ///   - roundedCorners: Which corners to round. Defaults to `.all`.
    /// - Returns: The view wrapped in a bordered, optionally-shadowed box.
    func nbBox(elevated: Bool = true, roundedCorners: NBCornerSet = .all) -> some View {
        modifier(
            NBBoxModifier(elevated: elevated, roundedCorners: roundedCorners)
        )
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(spacing: 12.0) {
        Text("Harry Potter")
            .padding(8.0)
            .nbBox()

        Text("Harry Potter")
            .padding(8.0)
            .background { Color.orange }
            .nbBox(roundedCorners: .right)

        Text("Harry Potter")
            .padding(8.0)
            .background { Color.orange }
            .nbBox(elevated: false)

    }.padding()
}
