import SwiftUI

public struct Progress: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme

    /** Value from 0 to 1 */
    @Binding private var value: CGFloat

    public init(value: Binding<CGFloat>) {
        _value = value
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                HStack(spacing: 0) {
                    // Progress bar
                    Rectangle()
                        .fill(theme.main)
                        .frame(width: max(0, min(value, 1)) * geometry.size.width, height: theme.size)
                    
                    if value > 0.001 && value < 0.99 {
                        Divider()
                            .frame(width: theme.borderWidth, height: geometry.size.height)
                            .background(Color.black)
                    }
                    
                    // Background bar
                    Rectangle()
                        .fill(theme.blank)
                        .frame(height: theme.size)
                }
            }
        }
        .frame(height: theme.size)
        .frame(maxWidth: .infinity, alignment: .leading)
        .neoBrutalismBox(elevated: false)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    VStack {
        Progress(value: .constant(0.0))
        Progress(value: .constant(0.52))
        Progress(value: .constant(0.2))
        Progress(value: .constant(1.0))
    }
}
