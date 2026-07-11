import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct StepperTests {
    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func stepper_default() -> some View {
        NBStepper("Quantity", value: .constant(3), in: 0...10)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func stepper_atMinimum() -> some View {
        NBStepper("Count", value: .constant(0), in: 0...5)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func stepper_atMaximum() -> some View {
        NBStepper("Count", value: .constant(5), in: 0...5)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func stepper_customLabel() -> some View {
        NBStepper(value: .constant(2), in: 0...10) {
            Label("Items", systemImage: "cart")
        }
        .prettifyForTest()
    }
}
