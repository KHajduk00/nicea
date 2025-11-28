pragma Singleton
import QtQuick

QtObject {
    // Base grayscale palette
    property color color0: "#CCCCCC" 
    property color color1: "#C2C2C2"
    property color color2: "#B8B8B8"
    property color color3: "#AEAEAE"
    property color color4: "#A4A4A4"
    property color color5: "#9A9A9A"
    property color color6: "#909090"
    property color color7: "#868686"
    property color color8: "#666666"
    property color color9: "#4D4D4D"
    
    // Contribution levels (gray-red scale, redest is most contributions)
    property color conlevel1: "#4D4D4D"   // level 1 - brightest (most contributions)
    property color conlevel2: "#996658"   // level 2 - medium-light gray
    property color conlevel3: "#BF5A4F"  // level 3 - medium gray
    property color conlevel4: "#D05B4E"  // level 4 - dark gray
    property color conlevel5: "#D35435"  // level 5 - darkest (least contributions)
    
    // Base UI colors
    property color color12: "#545454"
    property color color13: "#D35435"  // PFP background and dashboard border
    property color color14: "#474747"  // button default
    property color color15: "#333333"  // Text
}