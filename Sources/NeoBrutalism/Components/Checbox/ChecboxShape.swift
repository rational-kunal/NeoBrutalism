import SwiftUI

struct NBCheckboxShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let scale = min(rect.width, rect.height) / 16.0

        path.move(to: CGPoint(x: 4.0 * scale, y: 8 * scale))
        path.addLine(to: CGPoint(x: 7.0 * scale, y: 11.5 * scale))
        path.addLine(to: CGPoint(x: 11.5 * scale, y: 4.5 * scale))

        return path
    }
}
