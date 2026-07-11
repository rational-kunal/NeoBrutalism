@testable import NeoBrutalism
import SwiftUI
import Testing

@MainActor
private func buildMenuItems(@NBMenuBuilder _ content: () -> [NBMenuItem]) -> [NBMenuItem] {
    content()
}

@MainActor
private func buildTabs(@NBTabBuilder<Int> _ content: () -> [NBTab<Int>]) -> [NBTab<Int>] {
    content()
}

@MainActor
private func buildSegments(@NBSegmentBuilder<Int> _ content: () -> [NBSegmentItem<Int>]) -> [NBSegmentItem<Int>] {
    content()
}

@Suite @MainActor
struct NBMenuBuilderTests {
    @Test func blockFlattening_preservesOrder() {
        let items = buildMenuItems {
            NBMenuItem("A", role: .none) {}
            NBMenuItem("B", role: .destructive) {}
            NBMenuItem("C", role: .cancel) {}
        }
        #expect(items.map(\.role) == [nil, .destructive, .cancel])
    }

    @Test func buildOptional_nilCondition_contributesNoItems() {
        let includeExtra = false
        let items = buildMenuItems {
            NBMenuItem("A", role: .none) {}
            if includeExtra {
                NBMenuItem("B", role: .destructive) {}
            }
        }
        #expect(items.count == 1)
    }

    @Test func buildOptional_trueCondition_contributesItem() {
        let includeExtra = true
        let items = buildMenuItems {
            NBMenuItem("A", role: .none) {}
            if includeExtra {
                NBMenuItem("B", role: .destructive) {}
            }
        }
        #expect(items.count == 2)
        #expect(items[1].role == .destructive)
    }

    @Test func buildEither_picksTakenBranch() {
        let useDestructive = true
        let items = buildMenuItems {
            if useDestructive {
                NBMenuItem("A", role: .destructive) {}
            } else {
                NBMenuItem("A", role: .cancel) {}
            }
        }
        #expect(items.map(\.role) == [.destructive])
    }

    @Test func buildArray_loopFlattensInOrder() {
        let items = buildMenuItems {
            for i in 0 ..< 3 {
                NBMenuItem("Item \(i)", role: i == 0 ? .destructive : .none) {}
            }
        }
        #expect(items.count == 3)
        #expect(items[0].role == .destructive)
        #expect(items[1].role == nil)
        #expect(items[2].role == nil)
    }
}

@Suite @MainActor
struct NBTabBuilderTests {
    @Test func blockFlattening_preservesOrder() {
        let tabs = buildTabs {
            NBTab(value: 0) { Text("A") } label: { Text("A") }
            NBTab(value: 1) { Text("B") } label: { Text("B") }
        }
        #expect(tabs.map(\.value) == [0, 1])
    }

    @Test func buildOptional_nilCondition_contributesNoTabs() {
        let includeExtra = false
        let tabs = buildTabs {
            NBTab(value: 0) { Text("A") } label: { Text("A") }
            if includeExtra {
                NBTab(value: 1) { Text("B") } label: { Text("B") }
            }
        }
        #expect(tabs.map(\.value) == [0])
    }

    @Test func buildEither_picksTakenBranch() {
        let useSecond = true
        let tabs = buildTabs {
            if useSecond {
                NBTab(value: 1) { Text("B") } label: { Text("B") }
            } else {
                NBTab(value: 0) { Text("A") } label: { Text("A") }
            }
        }
        #expect(tabs.map(\.value) == [1])
    }

    @Test func buildArray_loopFlattensInOrder() {
        let tabs = buildTabs {
            for i in 0 ..< 3 {
                NBTab(value: i) { Text("\(i)") } label: { Text("\(i)") }
            }
        }
        #expect(tabs.map(\.value) == [0, 1, 2])
    }
}

@Suite @MainActor
struct NBSegmentBuilderTests {
    // NBSegmentBuilder only implements buildBlock — no buildExpression/buildOptional/buildEither/
    // buildArray, so `if`/`for` aren't supported in its body. Only flattening is tested here.
    @Test func blockFlattening_preservesOrder() {
        let segments = buildSegments {
            Text("One").nbSegment(0)
            Text("Two").nbSegment(1)
            Text("Three").nbSegment(2)
        }
        #expect(segments.map(\.tag) == [0, 1, 2])
    }
}
