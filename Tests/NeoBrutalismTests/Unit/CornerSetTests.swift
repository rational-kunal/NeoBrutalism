@testable import NeoBrutalism
import Testing

@Suite
struct CornerSetTests {
    @Test func top_isTopLeftAndTopRight() {
        #expect(NBCornerSet.top == [.topLeft, .topRight])
    }

    @Test func bottom_isBottomLeftAndBottomRight() {
        #expect(NBCornerSet.bottom == [.bottomLeft, .bottomRight])
    }

    @Test func left_isTopLeftAndBottomLeft() {
        #expect(NBCornerSet.left == [.topLeft, .bottomLeft])
    }

    @Test func right_isTopRightAndBottomRight() {
        #expect(NBCornerSet.right == [.topRight, .bottomRight])
    }

    @Test func all_containsEveryCorner() {
        #expect(NBCornerSet.all.contains(.topLeft))
        #expect(NBCornerSet.all.contains(.topRight))
        #expect(NBCornerSet.all.contains(.bottomLeft))
        #expect(NBCornerSet.all.contains(.bottomRight))
    }

    @Test func empty_containsNoCorner() {
        let none: NBCornerSet = []
        #expect(!none.contains(.topLeft))
        #expect(!none.contains(.topRight))
        #expect(!none.contains(.bottomLeft))
        #expect(!none.contains(.bottomRight))
    }
}

@Suite @MainActor
struct ControlGroupCornersTests {
    private let style = NBControlGroupStyle()

    @Test func singleSection_getsAllCorners() {
        #expect(style.corners(0, of: 1) == .all)
    }

    @Test func firstOfMany_getsLeftCorners() {
        #expect(style.corners(0, of: 3) == .left)
    }

    @Test func lastOfMany_getsRightCorners() {
        #expect(style.corners(2, of: 3) == .right)
    }

    @Test func middleOfMany_getsNoCorners() {
        #expect(style.corners(1, of: 3) == [])
    }

    @Test func firstOfTwo_getsLeftCorners() {
        #expect(style.corners(0, of: 2) == .left)
    }

    @Test func lastOfTwo_getsRightCorners() {
        #expect(style.corners(1, of: 2) == .right)
    }
}
