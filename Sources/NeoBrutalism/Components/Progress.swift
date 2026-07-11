import SwiftUI

public extension ProgressViewStyle where Self == NBProgressViewStyle {
    static var neoBrutalism: NBProgressViewStyle { .init() }
}

public struct NBProgressViewStyle: ProgressViewStyle {
    @Environment(\.nbTheme) var theme: NBTheme
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var indeterminatePhase = false

    public func makeBody(configuration: Configuration) -> some View {
        let isIndeterminate = configuration.fractionCompleted == nil
        let value = configuration.fractionCompleted ?? 0.0

        HStack(spacing: theme.spacing) {
            if let label = configuration.label {
                label
            }

            if isIndeterminate {
                IndeterminateProgressBar()
                    .frame(height: theme.size)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .nbBox(elevated: false)
            } else {
                NBBarMeter(fraction: value)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .nbBox(elevated: false)
            }
        }
    }

    @ViewBuilder
    private func IndeterminateProgressBar() -> some View {
        GeometryReader { geometry in
            let segmentWidth = geometry.size.width * 0.3
            let maxOffset = geometry.size.width - segmentWidth

            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(theme.bw)

                Rectangle()
                    .fill(theme.main)
                    .frame(width: segmentWidth)
                    .offset(x: reduceMotion ? maxOffset / 2 : (indeterminatePhase ? maxOffset : 0))
                    .animation(
                        reduceMotion ? nil : .easeInOut(duration: 1).repeatForever(autoreverses: true),
                        value: indeterminatePhase
                    )
            }
        }
        .onAppear {
            if !reduceMotion {
                indeterminatePhase = true
            }
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack {
        ProgressView(value: 0.0) { Text("Some Task") }
            .progressViewStyle(.neoBrutalism)

        ProgressView(value: 0.52)
            .progressViewStyle(.neoBrutalism)

        ProgressView(value: 0.2)
            .progressViewStyle(.neoBrutalism)

        ProgressView(value: 1.0)
            .progressViewStyle(.neoBrutalism)

        ProgressView { Text("Loading...") }
            .progressViewStyle(.neoBrutalism)
    }
}
