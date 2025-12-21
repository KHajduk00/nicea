import "."
import "../Themes" as Theme
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets

Rectangle {
    id: root

    color: Theme.Colors.color0
    border.width: Dimensions.border
    border.color: Theme.Colors.color14
    radius: Dimensions.radius
    implicitWidth: layout.width + Dimensions.barHPadding * 2
    implicitHeight: Dimensions.btnSize + Dimensions.barVPadding * 2
    Layout.fillWidth: true
    Layout.preferredHeight: implicitHeight

    //  profile picture - LEFT ALIGNED
    Rectangle {
        width: Dimensions.pfpSize
        height: Dimensions.pfpSize
        radius: width / 2
        color: Theme.Colors.color13
        border.width: Dimensions.border
        border.color: Theme.Colors.color14
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

    //  buttons - CENTERED
    RowLayout {
        id: layout

        anchors.centerIn: parent
        spacing: Dimensions.btnSpacing

        Repeater {
            model: [{
                "icon": "power-off.svg",
                "tip": "Power off"
            }, {
                "icon": "reload.svg",
                "tip": "Reboot"
            }, {
                "icon": "screenshot.svg",
                "tip": "Screenshot"
            }, {
                "icon": "search.svg",
                "tip": "Search"
            }, {
                "icon": "gaming.svg",
                "tip": "Steam"
            }, {
                "icon": "cpicker.svg",
                "tip": "Colour picker"
            }]

            Rectangle {
                id: btn

                width: Dimensions.btnSize
                height: Dimensions.btnSize
                radius: Dimensions.radius
                color: ma.containsMouse ? Theme.Colors.color7 : Theme.Colors.color1
                border.width: Dimensions.border
                border.color: Theme.Colors.color11
                scale: ma.containsMouse ? 0.95 : 1

                Image {
                    anchors.centerIn: parent
                    width: Dimensions.iconSize
                    height: Dimensions.iconSize
                    source: Theme.Config.iconsPath + "/" + modelData.icon
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }

                //  one Process per button
                Process {
                    id: proc

                    running: false
                    command: {
                        switch (modelData.icon) {
                        case "power-off.svg":
                            return ["systemctl", "poweroff"];
                        case "reload.svg":
                            return ["systemctl", "reboot"];
                        case "screenshot.svg":
                            return ["bash", "-c", Theme.Config.screenshotScript + " &disown"];
                        case "search.svg":
                            return ["bash", "-c", Theme.Config.searchScript + " &disown"];
                        case "gaming.svg":
                            return ["bash", "-c", Theme.Config.steamScript + " &disown"];
                        case "cpicker.svg":
                            return ["bash", "-c", Theme.Config.cpickerScript + " &disown"];
                        default:
                            return [];
                        }
                    }
                }

                MouseArea {
                    id: ma

                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: {
                        console.log("Button clicked:", modelData.icon);
                        const known = ["power-off.svg", "reload.svg", "screenshot.svg", "search.svg", "gaming.svg", "cpicker.svg"];
                        if (known.includes(modelData.icon)) {
                            console.log("Starting", modelData.tip, "process…");
                            proc.running = true; // fire the Process
                        }
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 200
                    }

                }

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }

                }

            }

        }

    }

}
