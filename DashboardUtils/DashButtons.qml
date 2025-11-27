import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import "../Themes" as Theme
import "."

Rectangle {
    id: root
    color: Theme.Colors.color15
    border.width: Dimensions.border
    border.color: Theme.Colors.color11
    radius: Dimensions.radius
    
    implicitWidth: layout.width + Dimensions.barHPadding * 2
    implicitHeight: Dimensions.btnSize + Dimensions.barVPadding * 2
    
    Layout.fillWidth: true
    Layout.preferredHeight: implicitHeight
    
    /*  profile picture - LEFT ALIGNED  */
    Rectangle {
        width: Dimensions.pfpSize
        height: Dimensions.pfpSize
        radius: width / 2
        color: Theme.Colors.color13
        border.width: Dimensions.border
        border.color: Theme.Colors.color8
        
        anchors.left: parent.left
        anchors.leftMargin: Dimensions.pfpLeftMargin
        anchors.verticalCenter: parent.verticalCenter
        
        ClippingWrapperRectangle {
            anchors.fill: parent
            anchors.margins: Dimensions.border
            radius: width / 2
            
            Image {
                anchors.fill: parent
                source: Theme.Config.profilePicture
                fillMode: Image.PreserveAspectCrop
                smooth: true
            }
        }
    }
    
    /*  buttons - CENTERED  */
    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: Dimensions.btnSpacing
        /*  all four buttons in one clean repeater  */
        Repeater {
            model: [
                {icon:"power-off.svg",  tip:"Power off"},
                {icon:"reload.svg",     tip:"Reboot"},
                {icon:"screenshot.svg", tip:"Screenshot"},
                {icon:"search.svg",     tip:"Search"}
            ]
            
            Rectangle {
                id: btn
                width: Dimensions.btnSize
                height: Dimensions.btnSize
                radius: Dimensions.radius
                color: ma.containsMouse ? Theme.Colors.color8 : Theme.Colors.color14
                border.width: Dimensions.border
                border.color: Theme.Colors.color11
                scale: ma.containsMouse ? 0.95 : 1.0
                
                Behavior on scale { NumberAnimation { duration: 200 } }
                Behavior on color { ColorAnimation { duration: 200 } }
                
                Image {
                    anchors.centerIn: parent
                    width: Dimensions.iconSize
                    height: Dimensions.iconSize
                    source: Theme.Config.iconsPath + "/" + modelData.icon
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
                
                Process {
                    id: proc
                    command: {
                        switch (modelData.icon) {
                            case "screenshot.svg":
                                return ["bash", "-c", Theme.Config.screenshotScript + " &disown"];
                            case "search.svg":
                                return ["bash", "-c", Theme.Config.searchScript + " &disown"];
                            default:
                                return [];
                        }
                    }
                    running: false
                }
                
                MouseArea {
                    id: ma
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: {
                        console.log("Button clicked:", modelData.icon)
                        if (modelData.icon === "screenshot.svg" || modelData.icon === "search.svg") {
                            console.log("Starting", modelData.tip, "process…")
                            proc.running = true
                            mouse.accepted = true  // Stop click propagation
                        } else {
                            console.log("dummy:", modelData.tip)
                        }
                    }
                }
            }
        }
    }
}