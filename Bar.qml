import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import "Themes" as Theme

PanelWindow {
    id: bar

    height: 30
    color: Theme.Colors.barBackground

    anchors {
        left: true
        right: true
        top: Theme.Config.barTop
        bottom: Theme.Config.barBottom
    }

    // Time Clock
    Text {
        id: clockText

        property var date: new Date()

        text: {
            const hours = clockText.date.getHours().toString().padStart(2, '0');
            const minutes = clockText.date.getMinutes().toString().padStart(2, '0');
            return `${hours}:${minutes}`;
        }
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        color: Theme.Colors.barClockText
        font.pixelSize: 16

        Timer {
            running: true
            repeat: true
            interval: 1000
            onTriggered: clockText.date = new Date()
        }

    }

    // Workspace indicators
    Row {
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        Repeater {
            model: Hyprland.workspaces

            delegate: Item {
                width: 22
                height: 22

                MouseArea {
                    anchors.fill: parent
                    onClicked: modelData.activate()
                }

                Image {
                    id: wsIcon

                    anchors.fill: parent
                    source: modelData.active ? "/home/khajduk/.config/quickshell/nicea/icons/circle-selected.svg" : "/home/khajduk/.config/quickshell/nicea/icons/circle-empty.svg"
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }

                ColorOverlay {
                    anchors.fill: wsIcon
                    source: wsIcon
                    color: modelData.active ? Theme.Colors.barWorkspaceActive : Theme.Colors.barWorkspaceInactive
                }

            }

        }

    }

}
