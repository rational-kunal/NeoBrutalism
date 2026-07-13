import SwiftUI

public extension NBTheme {
    /// Warm yellow accent (#FFDC58) on a peach background.
    static let sunnyPeach: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(1.0, 0.863, 0.345), // #FFDC58
            dark: .rgb(1.0, 0.863, 0.345) // same in dark
        ),
        bw: Color(
            light: .rgb(1.0, 1.0, 1.0), // #fff
            dark: .rgb(0.129, 0.129, 0.129) // #212121
        ),
        overlay: Color(
            light: .rgba(0, 0, 0, 0.8),
            dark: .rgba(0, 0, 0, 0.8)
        ),
        background: Color(
            light: .rgb(0.996, 0.949, 0.91), // #FEF2E8
            dark: .rgb(0.216, 0.255, 0.318) // #374151
        ),
        blank: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000
            dark: .rgb(1.0, 1.0, 1.0) // #fff
        ),
        border: Color(
            light: .rgb(0.0, 0.0, 0.0),
            dark: .rgb(0.0, 0.0, 0.0)
        ),
        text: Color(
            light: .rgb(0.0, 0.0, 0.0),
            dark: .rgb(0.902, 0.902, 0.902) // #e6e6e6
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0),
            dark: .rgb(0.0, 0.0, 0.0) // still black for contrast
        )
    )

    /// Pink accent (#FFA6F6) on a blush background — soft, rounded, and playful:
    /// generous corner radius, airy padding, and a rounded font design.
    static let bubblegum: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(1.0, 0.651, 0.965), // #FFA6F6
            dark: .rgb(1.0, 0.651, 0.965) // same in dark
        ),
        background: Color(
            light: .rgb(0.984, 0.929, 0.984), // #FBEDFB
            dark: .rgb(0.153, 0.161, 0.2) // .default's dark background
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0),
            dark: .rgb(0.0, 0.0, 0.0) // black on pastel pink in both modes
        ),
        padding: 16.0, // roomier interiors to match the soft look
        spacing: 14.0,
        borderRadius: 20.0, // pillowy, almost capsule corners
        fontDesign: .rounded
    )

    /// Lime accent (#A3E636) on a soft sage background — terminal-grade brutalist:
    /// square corners, a slab border, a heavy block shadow, and monospaced type.
    static let seafoam: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.639, 0.902, 0.212), // #A3E636
            dark: .rgb(0.639, 0.902, 0.212) // same in dark
        ),
        background: Color(
            light: .rgb(0.929, 0.969, 0.863), // #EDF7DC
            dark: .rgb(0.153, 0.161, 0.2) // .default's dark background
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0),
            dark: .rgb(0.0, 0.0, 0.0) // black on pastel lime in both modes
        ),
        padding: 10.0, // tighter interiors for a dense, utilitarian feel
        spacing: 10.0,
        borderWidth: 4.0, // slab outline
        borderRadius: 0.0, // sharp, uncompromising corners
        boxShadowX: 6.0, // heavier block shadow to match the weight
        boxShadowY: 6.0,
        fontDesign: .monospaced // terminal-grade utilitarian type
    )

    /// Orange accent (#FD9745) on a warm cream background — loud poster style:
    /// a thick border and a huge offset shadow that pops off the page.
    static let tangerine: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.992, 0.592, 0.271), // #FD9745
            dark: .rgb(0.992, 0.592, 0.271) // same in dark
        ),
        background: Color(
            light: .rgb(0.992, 0.941, 0.894), // #FDF0E4
            dark: .rgb(0.153, 0.161, 0.2) // .default's dark background
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0),
            dark: .rgb(0.0, 0.0, 0.0) // black on pastel orange in both modes
        ),
        padding: 14.0, // a little extra bulk to carry the heavy border and shadow
        borderWidth: 3.0, // bold outline
        borderRadius: 8.0, // rounder than default so the weight reads friendly, not harsh
        boxShadowX: 8.0, // poster-loud hard shadow
        boxShadowY: 8.0
    )

    /// Purple accent (#A388EE) on a pale lilac background — flat editorial elegance:
    /// a serif font, a hairline border, gently rounded corners, and no shadow at all.
    static let lavender: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.639, 0.533, 0.933), // #A388EE
            dark: .rgb(0.639, 0.533, 0.933) // same in dark
        ),
        background: Color(
            light: .rgb(0.941, 0.922, 0.984), // #F0EBFB
            dark: .rgb(0.153, 0.161, 0.2) // .default's dark background
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0),
            dark: .rgb(0.0, 0.0, 0.0) // black on pastel purple in both modes
        ),
        spacing: 14.0, // extra breathing room between elements
        borderWidth: 1.0, // hairline outline to match the delicate serif
        borderRadius: 14.0, // soft but not pillowy
        boxShadowX: 0.0, // fully flat — no offset shadow at all
        boxShadowY: 0.0,
        fontDesign: .serif
    )
}

#Preview {
    ScrollView {
        VStack(spacing: 24) {
            ForEach(
                [
                    ("Default", NBTheme.default), ("Sunny Peach", .sunnyPeach), ("Bubblegum", .bubblegum),
                    ("Seafoam", .seafoam), ("Tangerine", .tangerine), ("Lavender", .lavender),
                ],
                id: \.0
            ) { name, theme in
                GroupBox(name) {
                    VStack(alignment: .leading, spacing: 12) {
                        Button("Primary Button") {}
                        Toggle("Enabled", isOn: .constant(true))
                        NBBadge { Text("New") }
                    }
                }
                .neoBrutalism(theme: theme, applyBackground: true)
            }
        }
        .padding()
    }
}
