import SwiftUI

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
