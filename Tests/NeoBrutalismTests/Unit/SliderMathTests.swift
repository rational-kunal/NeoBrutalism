@testable import NeoBrutalism
import SwiftUI
import Testing

/// Pure fraction math for `NBSlider` — no rendering, so these run without a simulator snapshot.
@Suite @MainActor
struct SliderMathTests {
    private func slider(
        _ bounds: ClosedRange<Double>,
        step: Double? = nil
    ) -> NBSlider<Double> {
        NBSlider(value: .constant(bounds.lowerBound), in: bounds, step: step)
    }

    // MARK: - normalize

    @Test func normalize_mapsBoundsToUnitInterval() {
        let s = slider(0...100)
        #expect(s.normalize(0) == 0)
        #expect(s.normalize(50) == 0.5)
        #expect(s.normalize(100) == 1)
    }

    @Test func normalize_clampsOutOfRangeValues() {
        let s = slider(0...10)
        #expect(s.normalize(-5) == 0)
        #expect(s.normalize(99) == 1)
    }

    @Test func normalize_degenerateRangeIsZero() {
        #expect(slider(5...5).normalize(5) == 0)
    }

    // MARK: - denormalize

    @Test func denormalize_withoutStepMapsBackLinearly() {
        let s = slider(0...100)
        #expect(s.denormalize(0) == 0)
        #expect(s.denormalize(0.25) == 25)
        #expect(s.denormalize(1) == 100)
    }

    @Test func denormalize_snapsToNearestStep() {
        let s = slider(0...100, step: 5)
        #expect(s.denormalize(0.11) == 10)
        #expect(s.denormalize(0.13) == 15)
    }

    /// Regression: rounding to the *nearest* step overshoots when the span isn't a whole
    /// number of steps, so a full-right drag on `0...10 by 6` used to write 12 into the
    /// binding. The displayed thumb stayed pinned at the end, hiding the bad value.
    @Test func denormalize_neverEscapesUpperBound() {
        #expect(slider(0...10, step: 6).denormalize(1) == 10)
        #expect(slider(0...100, step: 30).denormalize(1) <= 100)
        #expect(slider(1...10, step: 4).denormalize(1) <= 10)
    }

    @Test func denormalize_neverEscapesLowerBound() {
        #expect(slider(3...10, step: 4).denormalize(0) >= 3)
    }

    @Test func denormalize_nonPositiveStepFallsBackToRawValue() {
        #expect(slider(0...10, step: 0).denormalize(0.5) == 5)
    }
}
