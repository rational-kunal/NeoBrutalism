import NeoBrutalism
import SwiftUI

/// Never executed. If this file stops compiling, a public API contract broke.
/// One line per public initializer/entry point; extend in every API task.
@available(*, unavailable)
@MainActor
private func publicAPISurface() {
    // MARK: Views

    let _ = NBAccordion { Text("Trigger") } content: { Text("Content") } // deprecated, must still compile
    let _ = NBAlert(type: .default, desc: { Text("Description") }, head: { Text("Title") })
    let _ = NBBadge(type: .default) { Text("Badge") }
    let _ = NBCollapsableContent { Text("Content") }
    let _ = NBCollapsibleTrigger { Text("Trigger") }
    let _ = NBCollapsable(isExpanded: .constant(true)) { Text("Content") }
    let _ = NBMenuItem("Edit", systemImage: "pencil", role: nil) {}
    let _ = NBMenuItem(role: nil, action: {}) { Text("Custom") }
    let _ = NBMenu { NBMenuItem("Edit") {} } label: { Text("Options") }
    let _ = NBRadioGroup(value: .constant(0)) { NBRadioItem(value: 0) { Text("First") } }
    let _ = NBRadioItem(value: 0) { Text("Item") }
    let _ = NBSegmentedPicker(selection: .constant(0)) { Text("One").nbSegment(0) }
    let _ = NBRoundSkeleton()
    let _ = NBTextSkeleton()
    let _ = NBSlider(value: .constant(CGFloat(0.5))) // pre-T17 shape must keep compiling
    let _ = NBStepper(value: .constant(1), in: 0 ... 9) { Text("Qty") }
    let _ = NBStepper("Qty", value: .constant(1), in: 0 ... 9) // pre-T18 shape must keep compiling
    let _ = NBTabView(selection: .constant(0)) { NBTab(value: 0) { Text("Content") } label: { Text("Tab") } }
    let _ = NBTab("Tab", systemImage: "flame.fill", value: 0) { Text("Content") }
    let _ = NBTab(value: 0) { Text("Content") } label: { Text("Tab") }
    let _ = Text("Content").nbDrawer(isPresented: .constant(false)) { Text("Drawer") }
    let _ = Text("Root").neoBrutalism()

    // MARK: Style protocol entry points

    let _: NBButtonStyle = .neoBrutalism(type: .default, variant: .default)
    let _: NBCheckboxToggleStyle = .neoBrutalismChecklist
    let _: NBSwitchToggleStyle = .neoBrutalismSwitch
    let _: NBRadioStyle = .neoBrutalismRadio
    let _: NBGroupBoxStyle = .neoBrutalism(type: .default, elevated: true)
    let _: NBControlGroupStyle = .neoBrutalism
    let _: NBGaugeStyle = .neoBrutalism
    let _: NBInputStyle = .neoBrutalism
    let _: NBLabelStyle = .neoBrutalism
    let _: NBLabeledContentStyle = .neoBrutalism
    let _: NBMenuStyle = .neoBrutalism
    let _: NBProgressViewStyle = .neoBrutalism
    let _: NBAccordionDisclosureGroupStyle = .neoBrutalismAccordion

    // MARK: Theme

    let _: NBTheme = .default.updateBy(main: .red)
}
