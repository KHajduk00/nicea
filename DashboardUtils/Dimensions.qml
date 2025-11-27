pragma Singleton
import QtQuick

QtObject {
    // ============================================================
    // GENERAL / UNIVERSAL
    // ============================================================
    readonly property int radius: 6               // universal corner-rounding
    readonly property int border: 1               // 1-px borders everywhere
    readonly property int spacing: 8              // default gap between items

    // ============================================================
    // DASHBOARD WINDOW
    // ============================================================
    readonly property int dashWidth: 650          // dashboard popup width
    readonly property int dashHeight: 300         // dashboard popup height
    readonly property int dashRadius: 12          // dashboard corner radius
    readonly property int dashBorderWidth: 2      // dashboard border thickness
    readonly property int dashPadding: 20         // internal padding (margins)
    readonly property int dashSpacing: 16         // spacing between modules

    // ============================================================
    // DASH BUTTONS (top bar with PFP + 4 buttons)
    // ============================================================
    readonly property int pfpSize: 40             // profile picture diameter
    readonly property int pfpLeftMargin: 20       // PFP distance from left edge
    
    readonly property int btnSize: 40             // icon button size
    readonly property int iconSize: 26            // SVG icon size inside buttons
    readonly property int btnSpacing: 12          // gap between buttons
    readonly property int barHPadding: 24         // left/right padding of button bar
    readonly property int barVPadding: 12         // top/bottom padding of button bar

    // ============================================================
    // CONTRIBUTION GRAPH
    // ============================================================
    readonly property int tileSize: 9             // contribution square size
    readonly property int tileGap: 2              // gap between squares
    readonly property int graphMargin: 15         // graph module internal padding
    readonly property int minGraphHeight: 120     // minimum height for graph
    readonly property int headerHeight: 24        // height of "@user / total" row
    
    // Graph Text Sizes
    readonly property int graphUsernameFontSize: 10    // "@username's Contributions"
    readonly property int graphTotalFontSize: 16       // "152 total"
}