import SwiftUI

public extension ProgressViewStyle where Self == NBProgressViewStyle {
    static var neoBrutalism: NBProgressViewStyle { .init() }
}

public struct NBProgressViewStyle: ProgressViewStyle {
    @Environment(\.nbTheme) var theme: NBTheme

    public func makeBody(configuration: Configuration) -> some View {
        let value = configuration.fractionCompleted ?? 0.0
        HStack(spacing: 0) {
            Text(value, format: .percent.precision(.fractionLength(0)))
                .padding(.horizontal)
                .frame(width: 100)
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    // Progress bar
                    Rectangle()
                        .fill(theme.main)
                        .frame(width: value * geometry.size.width, height: theme.size)
                    
                    if value > 0.001 && value < 0.99 {
                        Divider()
                            .frame(width: theme.borderWidth, height: geometry.size.height)
                            .background(Color.black)
                    }
                    
                    // Background bar
                    Rectangle()
                        .fill(theme.bw)
                        .frame(height: theme.size)
                }
            }
            .frame(height: theme.size)
            .frame(maxWidth: .infinity, alignment: .leading)
            .nbBox(elevated: false)
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack {
        ProgressView(value: 0.0)
            .progressViewStyle(.neoBrutalism)

        ProgressView(value: 0.52)
            .progressViewStyle(.neoBrutalism)

        ProgressView(value: 0.2)
            .progressViewStyle(.neoBrutalism)

        ProgressView(value: 1.0)
            .progressViewStyle(.neoBrutalism)
    }
}
