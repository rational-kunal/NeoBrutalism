import SwiftUI


protocol NeoBrutalismBase { }

extension NeoBrutalismBase where Self: View {
    
    // Usually is a border size
    var strokeWidth: CGFloat { 2.0 }

    // Usually is a vertical size
    var size: CGFloat { 16.0 }

    var padding: CGFloat { 14.0 }

    var spacing: CGFloat { 24.0 }

}

extension NeoBrutalismBase where Self: ViewModifier {

    var shadowOffset: CGFloat { 4.0 }

    var strokeWidth: CGFloat { 2.0 }

    var cornerRadius: CGFloat { 5.0 }

}
