pragma Singleton
import QtQuick
import Quickshell

QtObject {
    // ============================================================
    // PATHS
    // ============================================================
    readonly property string configPath: Quickshell.env("HOME") + "/.config/quickshell/nicea"
    readonly property string scriptsPath: configPath + "/DashboardUtils/scripts"
    readonly property string iconsPath: configPath + "/icons"
    
    // ============================================================
    // USER CONFIGURATION
    // ============================================================
    readonly property string githubUsername: "KHajduk00"
    readonly property string profilePicture: iconsPath + "/pfp.jpg"
    
    // ============================================================
    // SCRIPTS
    // ============================================================
    readonly property string screenshotScript: scriptsPath + "/screenshot.sh"
    readonly property string searchScript: scriptsPath + "/search.sh"
    readonly property string steamScript: scriptsPath + "/steam.sh"
    readonly property string cpickerScript: scriptsPath + "/cpicker.sh"
}