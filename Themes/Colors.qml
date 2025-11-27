pragma Singleton
import QtQuick

QtObject {
    // Base grayscale palette - keep your original colors
    property color color0: "#CCCCCC"   // lightest text
    property color color1: "#C2C2C2"
    property color color2: "#B8B8B8"   // secondary text
    property color color3: "#AEAEAE"
    property color color4: "#A4A4A4"
    property color color5: "#9A9A9A"
    property color color6: "#909090"
    property color color7: "#868686"
    
    // FIXED: Better contrast for contribution levels (grayscale, darkest to lightest)
    property color color8: "#CCCCCC"   // level 4 - brightest (most contributions)
    property color color9: "#999999"   // level 3 - medium-light gray
    property color color10: "#666666"  // level 2 - medium gray
    property color color11: "#4D4D4D"  // level 1 - dark gray
    
    // Base UI colors
    property color color12: "#545454"
    property color color13: "#4A4A4A"  // PFP background
    property color color14: "#474747"  // button default
    property color color15: "#333333"  // level 0 (no contributions) & main background
}