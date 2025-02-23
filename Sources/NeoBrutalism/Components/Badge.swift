import SwiftUI

public struct Badge<Content>: NeoBrutalismBase, View where Content: View {
    public enum BadgeType {
        case primary, neutral, danger
    }

    private let type: BadgeType
    private let content: Content

    public init(type: BadgeType = .primary, @ViewBuilder content: () -> Content) {
        self.type = type
        self.content = content()
    }
    
    var padding: CGFloat { 10.0 }
    
    private var textForegroundColor: Color {
        switch type {
        case .neutral:
            return Theme.standard.text
        case .primary:
            return Theme.standard.text
        case .danger:
            return Theme.standard.textDark
        }
    }

    public var body: some View {
        ZStack {
            content
                .font(.caption)
                .foregroundStyle(textForegroundColor)
        }
        .padding(.horizontal, padding)
        .padding(.vertical, 2.0)
        
        .background(content: {
            switch type {
            case .neutral:
                Theme.standard.clear
            case .primary:
                Theme.standard.main
            case .danger:
                Theme.standard.dark
                
            }
        })
        .elevatedBox(elevated: false)
    }
}

@available(iOS 17.0, *)
#Preview {
    ZStack {
        Color.gray
            .ignoresSafeArea()
        VStack(spacing: 18.0) {
            Badge {
                Text("Xyz")
            }
            
            Badge(type: .neutral) {
                Text("Xyz")
                    .font(.title)
            }
            
            Badge(type: .danger) {
                Text("Xyz")
            }
            
            Spacer()
        }
        .padding()
    }
}

