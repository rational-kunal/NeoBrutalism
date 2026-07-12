import SwiftUI

public extension NBTheme {

    public static let sunnyPeach: NBTheme = NBTheme.default.updateBy(
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

    public static let rosyPink: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(1.0, 0.42, 0.42), // #FF6B6B - coral/pink
            dark: .rgb(0.949, 0.38, 0.38) // #F26161 - slightly darker for dark mode
        ),
        bw: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(0.129, 0.129, 0.129) // #212121
        ),
        overlay: Color(
            light: .rgba(0, 0, 0, 0.6),
            dark: .rgba(0, 0, 0, 0.6)
        ),
        background: Color(
            light: .rgb(0.988, 0.843, 0.843), // #FCD7D7 - light pink
            dark: .rgb(0.18, 0.196, 0.243) // #2E323E - dark blue-gray
        ),
        blank: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF - white
            dark: .rgb(1.0, 1.0, 1.0) // #FFFFFF - stays white in dark mode
        ),
        border: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000 - black
            dark: .rgb(0.0, 0.0, 0.0) // #000000 - stays black in dark mode
        ),
        text: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000 - black
            dark: .rgb(0.902, 0.902, 0.902) // #E6E6E6 - light gray
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000 - black for contrast on pink
            dark: .rgb(0.0, 0.0, 0.0) // #000000 - stays black for contrast
        )
    )

    public static let espresso: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.592, 0.290, 0.137), // #974A23 - rich brown
            dark: .rgb(0.788, 0.384, 0.184) // #C9622F - warmer brown for dark mode
        ),
        bw: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(0.129, 0.129, 0.129) // #212121
        ),
        overlay: Color(
            light: .rgba(0, 0, 0, 0.6),
            dark: .rgba(0, 0, 0, 0.6)
        ),
        background: Color(
            light: .rgb(0.976, 0.929, 0.902), // #F9EDE6 - creamy beige
            dark: .rgb(0.180, 0.161, 0.149) // #2E2926 - dark brown-gray
        ),
        blank: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(1.0, 1.0, 1.0) // #FFFFFF
        ),
        border: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.0, 0.0, 0.0) // #000000
        ),
        text: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.902, 0.902, 0.902) // #E6E6E6
        ),
        mainText: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF - white text on brown
            dark: .rgb(0.0, 0.0, 0.0) // #000000 - black for contrast
        )
    )

    public static let limelight: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.886, 0.992, 0.537), // #E2FD89 - bright lime
            dark: .rgb(0.522, 0.667, 0.012) // #85AA03 - deeper lime
        ),
        bw: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(0.129, 0.129, 0.129) // #212121
        ),
        overlay: Color(
            light: .rgba(0, 0, 0, 0.6),
            dark: .rgba(0, 0, 0, 0.6)
        ),
        background: Color(
            light: .rgb(0.953, 0.976, 0.898), // #F3F9E5 - very light lime
            dark: .rgb(0.153, 0.196, 0.004) // #273201 - dark olive
        ),
        blank: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000 - black for high contrast
            dark: .rgb(1.0, 1.0, 1.0) // #FFFFFF
        ),
        border: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.0, 0.0, 0.0) // #000000
        ),
        text: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.886, 0.992, 0.537) // #E2FD89 - lime text for readability
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000 - black on lime
            dark: .rgb(0.0, 0.0, 0.0) // #000000
        )
    )

    public static let lavenderDream: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.839, 0.859, 0.980), // #D6DBFA - soft lavender
            dark: .rgb(0.216, 0.478, 0.275) // #37A960 - green accent for dark
        ),
        bw: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(0.129, 0.129, 0.129) // #212121
        ),
        overlay: Color(
            light: .rgba(0, 0, 0, 0.6),
            dark: .rgba(0, 0, 0, 0.6)
        ),
        background: Color(
            light: .rgb(0.949, 0.953, 0.988), // #F2F3FC - very light lavender
            dark: .rgb(0.349, 0.137, 0.722) // #5923B8 - deep purple
        ),
        blank: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(1.0, 1.0, 1.0) // #FFFFFF
        ),
        border: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.675, 0.624, 0.733) // #AC9FBB - light purple for visibility
        ),
        text: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.839, 0.859, 0.980) // #D6DBFA - lavender text
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.0, 0.0, 0.0) // #000000
        )
    )

    public static let twilightMist: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.671, 0.588, 0.635), // #AB96A2 - dusty mauve
            dark: .rgb(0.502, 0.412, 0.859) // #8069DB - brighter purple for dark
        ),
        bw: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(0.129, 0.129, 0.129) // #212121
        ),
        overlay: Color(
            light: .rgba(0, 0, 0, 0.6),
            dark: .rgba(0, 0, 0, 0.6)
        ),
        background: Color(
            light: .rgb(0.933, 0.918, 0.929), // #EEE9ED - very light mauve
            dark: .rgb(0.302, 0.227, 0.431) // #4D3A6E - deep purple-gray
        ),
        blank: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(1.0, 1.0, 1.0) // #FFFFFF
        ),
        border: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.498, 0.455, 0.690) // #7F74B0 - lighter purple for visibility
        ),
        text: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.902, 0.902, 0.902) // #E6E6E6
        ),
        mainText: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF - white on mauve
            dark: .rgb(0.0, 0.0, 0.0) // #000000
        )
    )

    public static let mintForest: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.459, 0.780, 0.647), // #75C7A5 - mint green
            dark: .rgb(0.714, 0.953, 0.627) // #B6F3A0 - bright mint
        ),
        bw: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(0.129, 0.129, 0.129) // #212121
        ),
        overlay: Color(
            light: .rgba(0, 0, 0, 0.6),
            dark: .rgba(0, 0, 0, 0.6)
        ),
        background: Color(
            light: .rgb(0.878, 0.886, 0.855), // #E0E2DA - soft sage
            dark: .rgb(0.090, 0.188, 0.118) // #17301E - forest green
        ),
        blank: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(1.0, 1.0, 1.0) // #FFFFFF
        ),
        border: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.0, 0.0, 0.0) // #000000
        ),
        text: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.878, 0.886, 0.855) // #E0E2DA - sage text
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.0, 0.0, 0.0) // #000000
        )
    )

    public static let earthyNeutral: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.996, 0.965, 0.788), // #FEF6C9 - pale yellow
            dark: .rgb(0.831, 0.875, 0.784) // #D4DFC7 - sage green
        ),
        bw: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(0.129, 0.129, 0.129) // #212121
        ),
        overlay: Color(
            light: .rgba(0, 0, 0, 0.6),
            dark: .rgba(0, 0, 0, 0.6)
        ),
        background: Color(
            light: .rgb(0.949, 0.945, 0.933), // #F2F1EE - warm white
            dark: .rgb(0.447, 0.341, 0.322) // #725752 - warm brown
        ),
        blank: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(1.0, 1.0, 1.0) // #FFFFFF
        ),
        border: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.0, 0.0, 0.0) // #000000
        ),
        text: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.902, 0.902, 0.902) // #E6E6E6
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.0, 0.0, 0.0) // #000000
        )
    )

    public static let thistleGlow: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.867, 0.741, 0.835), // #DDBDD5 - soft thistle
            dark: .rgb(0.675, 0.624, 0.733) // #AC9FBB - muted purple
        ),
        bw: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(0.129, 0.129, 0.129) // #212121
        ),
        overlay: Color(
            light: .rgba(0, 0, 0, 0.6),
            dark: .rgba(0, 0, 0, 0.6)
        ),
        background: Color(
            light: .rgb(0.969, 0.957, 0.965), // #F7F4F6 - very light purple-gray
            dark: .rgb(0.114, 0.118, 0.173) // #1D1E2C - deep navy
        ),
        blank: Color(
            light: .rgb(1.0, 1.0, 1.0), // #FFFFFF
            dark: .rgb(1.0, 1.0, 1.0) // #FFFFFF
        ),
        border: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.0, 0.0, 0.0) // #000000
        ),
        text: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000
            dark: .rgb(0.902, 0.902, 0.902) // #E6E6E6
        ),
        mainText: Color(
            light: .rgb(0.0, 0.0, 0.0), // #000000 - black on thistle
            dark: .rgb(0.0, 0.0, 0.0) // #000000
        )
    )
}
