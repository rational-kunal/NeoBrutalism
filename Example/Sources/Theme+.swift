import NeoBrutalism
import SwiftUI

public extension NBTheme {
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
}
