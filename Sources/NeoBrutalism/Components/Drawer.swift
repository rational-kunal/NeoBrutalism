import SwiftUI

public extension View {
    func nbDrawer<Content>(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(NBShowDrawer(isPresented: isPresented, onDismiss: onDismiss, drawerContent: content))
    }
}

struct NBShowDrawer<DrawerContent>: ViewModifier where DrawerContent: View {
    @Environment(\.nbTheme) private var theme: NBTheme

    @Binding private var isPresented: Bool
    let onDismiss: (() -> Void)?
    let drawerContent: DrawerContent

    @State private var contentHeight: CGFloat = 100.0

    public init(
        isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil,
        @ViewBuilder drawerContent: () -> DrawerContent
    ) {
        _isPresented = isPresented
        self.onDismiss = onDismiss
        self.drawerContent = drawerContent()
    }

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented, onDismiss: onDismiss) {
                VStack(spacing: 0.0) {
                    topBorder
                    dragIndicator
                    drawerContent
                }
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                contentHeight = proxy.size.height
                            }
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(theme.background)
                .foregroundStyle(theme.text)
                .presentationCornerRadius(0)
                .presentationDetents([.height(contentHeight)])
                .presentationDragIndicator(.hidden)
            }
    }
}

extension NBShowDrawer {
    private var topBorder: some View {
        Rectangle()
            .fill(theme.border)
            .frame(height: theme.borderWidth)
            .edgesIgnoringSafeArea(.horizontal)
    }

    private var dragIndicator: some View {
        Rectangle()
            .fill(theme.text)
            .cornerRadius(2 * theme.borderRadius)
            .frame(width: 100.0, height: theme.smspacing)
            .padding(theme.smpadding)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var isShowingSheet = true
    VStack {
        NBButton {
            Text("Open the Chamber of Secrets")
        } action: {
            isShowingSheet.toggle()
        }
    }
    .nbDrawer(isPresented: $isShowingSheet) {
        VStack(spacing: 16) {
            Text("The Unbreakable Vow")
                .font(.title)

            Text("By tapping 'I Agree', you solemnly swear that you are up to no good.")
                .padding(2.0)

            NBButton {
                Text("I Agree")
            } action: {
                isShowingSheet.toggle()
            }
            .padding(.top)
        }
    }
}
