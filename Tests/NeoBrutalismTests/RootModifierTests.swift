import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

/// Contract test for the `.neoBrutalism()` root modifier: every supported control here has
/// **no per-view style modifier**, so this fails if any default style silently drops out.
@Suite(.snapshots) @MainActor
struct RootModifierTests {
    @Test func kitchenSink() {
        assertNBSnapshot(
            of: VStack(alignment: .leading, spacing: 16) {
                Button("Styled Button") {}

                Toggle("Checklist Item", isOn: .constant(true))

                TextField("", text: .constant("text"))

                ProgressView(value: 0.6)

                DisclosureGroup("Expand Me") {
                    Text("Hidden content")
                }

                GroupBox("Card") {
                    Text("Native GroupBox as a card.")
                }

                ControlGroup {
                    Button("Bold") {}
                    Button("Italic") {}
                }

                Gauge(value: 0.6) { Text("Gauge") }

                Label("Label", systemImage: "star.fill")

                LabeledContent("Key", value: "Value")

                Menu("Menu") {
                    Button("Item") {}
                }
            }
            .neoBrutalism()
        )
    }

    @Test func kitchenSinkRoundedFont() {
        assertNBSnapshot(
            of: VStack(alignment: .leading, spacing: 16) {
                Button("Styled Button") {}

                Toggle("Checklist Item", isOn: .constant(true))

                TextField("", text: .constant("text"))

                ProgressView(value: 0.6)

                DisclosureGroup("Expand Me") {
                    Text("Hidden content")
                }

                GroupBox("Card") {
                    Text("Native GroupBox as a card.")
                }

                ControlGroup {
                    Button("Bold") {}
                    Button("Italic") {}
                }

                Gauge(value: 0.6) { Text("Gauge") }

                Label("Label", systemImage: "star.fill")

                LabeledContent("Key", value: "Value")

                Menu("Menu") {
                    Button("Item") {}
                }
            }
            .neoBrutalism(theme: .default.updateBy(fontDesign: .rounded))
        )
    }
}
