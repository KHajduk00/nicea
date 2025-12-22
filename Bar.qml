import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import "Themes" as Theme
import "BarUtils" as BarUtils

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

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Left side: Workspaces
        Rectangle {
            Layout.preferredWidth: workspaceRow.width + 20
            Layout.fillHeight: true
            color: Theme.Colors.barWorkspaceBackground

            Row {
                id: workspaceRow
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

        // Triangle separator: workspace background to transparent
        BarUtils.TriangleSeparator {
            fillColor: Theme.Colors.barWorkspaceBackground
            backgroundColor: Theme.Colors.barBackground
            pointingRight: true
        }

        // Center: Focused Window
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Theme.Colors.barBackground

            Text {
                anchors.centerIn: parent
                text: Hyprland.focusedMonitor.activeWindow?.title ?? ""
                color: Theme.Colors.barClockText
                font.pixelSize: 14
                elide: Text.ElideRight
                width: parent.width - 20
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Triangle separator: transparent to date background
        BarUtils.TriangleSeparator {
            fillColor: Theme.Colors.barBackground
            backgroundColor: Theme.Colors.barDateBackground
            pointingRight: true
        }

        // Date section
        Rectangle {
            Layout.preferredWidth: dateText.width + 20
            Layout.fillHeight: true
            color: Theme.Colors.barDateBackground

            Text {
                id: dateText
                property var date: new Date()
                text: {
                    const month = (dateText.date.getMonth() + 1).toString().padStart(2, '0');
                    const day = dateText.date.getDate().toString().padStart(2, '0');
                    const year = dateText.date.getFullYear().toString().slice(-2);
                    return `${month}/${day}/${year}`;
                }
                anchors.centerIn: parent
                color: Theme.Colors.barDateForeground
                font.pixelSize: 16

                Timer {
                    running: true
                    repeat: true
                    interval: 1000
                    onTriggered: dateText.date = new Date()
                }
            }
        }

        // Triangle separator: date to clock background
        BarUtils.TriangleSeparator {
            Layout.leftMargin: -1
            fillColor: Theme.Colors.barDateBackground
            backgroundColor: Theme.Colors.barClockBackground
            pointingRight: true
        }

        // Right side: Clock
        Rectangle {
            Layout.preferredWidth: clockText.width + 20
            Layout.fillHeight: true
            color: Theme.Colors.barClockBackground

            Text {
                id: clockText
                property var date: new Date()
                text: {
                    const hours = clockText.date.getHours().toString().padStart(2, '0');
                    const minutes = clockText.date.getMinutes().toString().padStart(2, '0');
                    return `${hours}:${minutes}`;
                }
                anchors.centerIn: parent
                color: Theme.Colors.barClockForeground
                font.pixelSize: 16

                Timer {
                    running: true
                    repeat: true
                    interval: 1000
                    onTriggered: clockText.date = new Date()
                }
            }
        }
    }
}