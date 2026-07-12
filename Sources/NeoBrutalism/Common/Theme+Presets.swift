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

    /// Pink accent (#FFA6F6) on a blush background.
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
        )
    )

    /// Lime accent (#A3E636) on a soft sage background.
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
        )
    )

    /// Orange accent (#FD9745) on a warm cream background.
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
        )
    )

    /// Purple accent (#A388EE) on a pale lilac background.
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
        )
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
