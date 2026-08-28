@testable import NeoBrutalism
import CoreGraphics
import Testing

@Suite
struct MenuLayoutTests {
    @Test(arguments: [
        (containerHeight: CGFloat(0), expectedCap: CGFloat(0)),
        (containerHeight: CGFloat(320), expectedCap: CGFloat(192)),
        (containerHeight: CGFloat(844), expectedCap: CGFloat(506.4)),
        (containerHeight: CGFloat(1_024), expectedCap: CGFloat(614.4)),
    ])
    func scrollCap_usesContainerHeight(containerHeight: CGFloat, expectedCap: CGFloat) {
        #expect(NBMenuLayout.scrollCap(containerHeight: containerHeight) == expectedCap)
    }

    @Test func needsScroll_changesAtContainerRelativeCap() {
        let containerHeight = CGFloat(400)

        #expect(!NBMenuLayout.needsScroll(contentHeight: 240, containerHeight: containerHeight))
        #expect(NBMenuLayout.needsScroll(contentHeight: 241, containerHeight: containerHeight))
    }
}
