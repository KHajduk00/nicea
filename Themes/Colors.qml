pragma Singleton
import QtQuick

QtObject {
    // Contribution levels (gray-red scale, redest is most contributions)
    property color conlevel1: "#4D4D4D"   // level 1 - brightest (most contributions)
    property color conlevel2: "#996658"   // level 2 - medium-light gray
    property color conlevel3: "#BF5A4F"  // level 3 - medium gray
    property color conlevel4: "#D05B4E"  // level 4 - dark gray
    property color conlevel5: "#D35435"  // level 5 - darkest (least contributions)
    
    // Bar-specific colors
    property color barBackground:        "#282828"   // bg0_hard
    property color barClockText:         "#ebdbb2"   // fg1
    property color barWorkspaceActive:   "#ebdbb2"   // fg1
    property color barWorkspaceInactive: "#a89984"   // gray4
    property color barWorkspaceBackground: "#504945" // bg2
    property color barClockBackground:     "#ebdbb2" // fg1
    property color barClockForeground:     "#282828" // bg0_hard
    property color barDateBackground:  "#504945" // bg2
    property color barDateForeground:  "#ebdbb2" // fg1
    
    // GitHub Contributions Graph colors
    property color graphBackground:      "#1D2021"   // bg1
    property color graphBorder:          "#504945"   // bg2
    property color graphText:            "#ebdbb2"   // fg1
    
    // Dashboard Bar colors (profile + buttons)
    property color dashboardBackground:  "#1D2021"   // bg1
    property color dashboardBorder:      "#504945"   // bg2
    property color dashboardPfpBackground:"#fb4934"   // bright-red
    property color dashboardPfpBorder:   "#504945"   // bg2
    property color dashboardButtonDefault:"#ebdbb2"   // neutral-blue
    property color dashboardButtonHover: "#d79921"   // neutral-yellow
    property color dashboardButtonBorder:"#504945"   // bg2
    
    // Dashboard Popup colors
    property color dashboardPopupBackground: "#1D2021" // bg1
    property color dashboardPopupBorder:     "#504945" // bg2
}