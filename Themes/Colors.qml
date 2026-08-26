pragma Singleton
import QtQuick

QtObject {
    // Palette: #000000 black · #18526F deep teal · #2298D3 blue
    //          #71C7F2 sky · #B4E6FF ice · #FCAECB pink (accent)

    // Bar-specific colors
    property color barBackground:        "#000000"   // black - main bar
    property color barClockText:         "#B4E6FF"   // ice - center title text
    property color barMediaText:         "#71C7F2"   // sky - now playing
    property color barMediaHover:        "#B4E6FF"   // ice - transport button hover
    property color barMediaDisabled:     "#18526F"   // deep teal - control unavailable
    property color barWorkspaceActive:   "#B4E6FF"   // ice - focused workspace
    property color barWorkspaceInactive: "#2298D3"   // blue - dimmed workspace
    property color barWorkspaceBackground: "#18526F" // deep teal
    property color barClockBackground:     "#B4E6FF" // ice - inverted end cap
    property color barClockForeground:     "#000000" // black on ice
    property color barDateBackground:  "#18526F" // deep teal
    property color barDateForeground:  "#B4E6FF" // ice
    property color barVolumeBackground: "#000000" // black - empty track (whole section)
    property color barVolumeFill:       "#FCAECB" // pink - current level
    property color barVolumeMuted:      "#2298D3" // blue - shown when muted

    // Action tray (Arch logo + quick buttons)
    property color barTrayBackground: "#000000" // black
    property color barTrayLogo:       "#B4E6FF" // ice - logo tint
    property color barTrayAccent:     "#FCAECB" // pink - logo tint when pinned
    property color trayButtonDefault: "#B4E6FF" // ice
    property color trayButtonHover:   "#71C7F2" // sky
    property color trayButtonBorder:  "#2298D3" // blue
}
