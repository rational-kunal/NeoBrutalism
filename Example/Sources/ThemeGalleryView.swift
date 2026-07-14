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

/// A live demo of every bundled `NBTheme` preset: pick one and watch a representative cluster
/// of components — and the shared top bar — re-skin instantly. The selected preset and dark
/// mode are owned by ``ContentView`` so the whole app stays in sync.
struct ThemeGalleryView: View {
    @Binding var selection: ThemeChoice
    @State private var isToggleOn: Bool = true
    @State private var text: String = ""
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var themeSwitchAnimation: Animation? {
        reduceMotion ? .none : .interactiveSpring()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: selection.theme.xlspacing) {
                Text("Theme Gallery")
                    .font(.largeTitle)
                swatchPicker
                previewCluster
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(selection.theme.padding)
        }
        // Restyle this tab's controls with the selected preset. The theme itself already comes
        // from ContentView (so the top bar matches); this also wires up the component styles.
        .neoBrutalism(theme: selection.theme)
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
                // A solid color chip that fills its bordered box, so the swatch and its
                // container share the same neobrutalist rounded-rectangle shape.
                Rectangle()
                    .fill(choice.theme.main)
                    .frame(width: 46, height: 46)
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
    @Previewable @State var selection: ThemeChoice = .defaultBlue
    ThemeGalleryView(selection: $selection)
        .nbTheme(selection.theme)
}
