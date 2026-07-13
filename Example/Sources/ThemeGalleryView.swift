import NeoBrutalism
import SwiftUI

enum ThemeChoice: String, CaseIterable, Identifiable {
    case defaultBlue
    case sunnyPeach
    case bubblegum
    case seafoam
    case tangerine
    case lavender

    var id: String { rawValue }

    var title: String {
        switch self {
        case .defaultBlue: return "Default"
        case .sunnyPeach: return "Sunny Peach"
        case .bubblegum: return "Bubblegum"
        case .seafoam: return "Seafoam"
        case .tangerine: return "Tangerine"
        case .lavender: return "Lavender"
        }
    }

    var theme: NBTheme {
        switch self {
        case .defaultBlue: return .default
        case .sunnyPeach: return .sunnyPeach
        case .bubblegum: return .bubblegum
        case .seafoam: return .seafoam
        case .tangerine: return .tangerine
        case .lavender: return .lavender
        }
    }
}

/// A live demo of every bundled `NBTheme` preset: pick one, toggle dark mode, and watch a
/// representative cluster of components re-skin instantly.
struct ThemeGalleryView: View {
    @State private var selection: ThemeChoice = .defaultBlue
    @State private var colorScheme: ColorScheme = .light
    @State private var isToggleOn: Bool = true
    @State private var text: String = ""
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var themeSwitchAnimation: Animation? {
        reduceMotion ? .none : .interactiveSpring()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: selection.theme.xlspacing) {
                header
                swatchPicker
                previewCluster
            }
            .padding(selection.theme.padding)
        }
        .neoBrutalism(theme: selection.theme, applyBackground: true)
        .colorScheme(colorScheme)
    }

    private var header: some View {
        HStack {
            Text("Theme Gallery")
                .font(.largeTitle)
            Spacer()
            Button {
                withAnimation(themeSwitchAnimation) {
                    colorScheme = colorScheme == .light ? .dark : .light
                }
            } label: {
                Image(systemName: colorScheme == .light ? "moon" : "sun.max")
            }
            .buttonStyle(.neoBrutalism(type: .neutral))
        }
    }

    private var swatchPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(ThemeChoice.allCases) { choice in
                    swatchButton(for: choice)
                }
            }
            .padding(.vertical, 4)
        }
    }

    private func swatchButton(for choice: ThemeChoice) -> some View {
        let isSelected = selection == choice

        return Button {
            withAnimation(themeSwitchAnimation) {
                selection = choice
            }
        } label: {
            VStack(spacing: 6) {
                Circle()
                    .fill(choice.theme.main)
                    .frame(width: 36, height: 36)
                    .nbBox(elevated: isSelected)
                Text(choice.title)
                    .font(.caption2)
                    .foregroundStyle(selection.theme.text)
            }
        }
        .buttonStyle(.plain)
        .opacity(isSelected ? 1.0 : 0.55)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private var previewCluster: some View {
        GroupBox("Preview") {
            VStack(alignment: .leading, spacing: selection.theme.spacing) {
                Text("A themed cluster, driven entirely by the selected preset.")

                Button("Primary Action") {}

                Toggle("Enabled", isOn: $isToggleOn)

                TextField("Type something...", text: $text)

                ProgressView(value: 0.6)

                NBBadge { Text("New") }
            }
        }
    }
}

#Preview {
    ThemeGalleryView()
}
