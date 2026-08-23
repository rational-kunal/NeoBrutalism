import SwiftUI
import UIKit

/// Hosts overlay content (menus, dialogs) in its own `UIWindow`, layered above the app's key
/// window so content is never clipped or painted-under by sibling views in the presenting
/// hierarchy.
@MainActor
final class NBOverlayWindow {
    private var window: UIWindow?

    func show<Content: View>(@ViewBuilder content: () -> Content) {
        guard let scene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive })
        else { return }

        let hostingController = UIHostingController(rootView: content())
        hostingController.view.backgroundColor = .clear

        let window = self.window ?? UIWindow(windowScene: scene)
        window.rootViewController = hostingController
        window.backgroundColor = .clear
        window.windowLevel = .alert + 1
        window.isHidden = false
        self.window = window
    }

    func hide() {
        window?.isHidden = true
        window?.rootViewController = nil
        window = nil
    }
}
