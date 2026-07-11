import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct StepperTests {
    @Test func stepper_default() {
        assertNBSnapshot(of: NBStepper("Quantity", value: .constant(3), in: 0...10))
    }

    @Test func stepper_atMinimum() {
        assertNBSnapshot(of: NBStepper("Count", value: .constant(0), in: 0...5))
    }

    @Test func stepper_atMaximum() {
        assertNBSnapshot(of: NBStepper("Count", value: .constant(5), in: 0...5))
    }

    @Test func stepper_customLabel() {
        assertNBSnapshot(
            of: NBStepper(value: .constant(2), in: 0...10) {
                Label("Items", systemImage: "cart")
            }
        )
    }
}
