import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import "Themes" as Theme
import "BarUtils" as BarUtils
import "Notifications" as Notif
import "Media" as Media

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

        // Far left: Arch logo + hover/pin action tray
        BarUtils.ActionTray {
            id: actionTray
            Layout.preferredWidth: implicitWidth
            Layout.fillHeight: true
        }

        // Triangle separator: tray to workspace background
        BarUtils.TriangleSeparator {
            Layout.leftMargin: -1
            fillColor: Theme.Colors.barTrayBackground
            backgroundColor: Theme.Colors.barWorkspaceBackground
            pointingRight: true
        }

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

        // Center: Focused window title, taken over by notifications when they
        // arrive. The title fades out and the notification fades in over it.
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Theme.Colors.barBackground

            // Focused window title — hidden while a notification is showing
            Text {
                anchors.centerIn: parent
                width: parent.width - 20
                text: ToplevelManager.activeToplevel?.title ?? ""
                color: Theme.Colors.barClockText
                font.pixelSize: 14
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
                opacity: (Notif.NotificationService.active || Media.MprisService.active) ? 0 : 1

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
            }

            // Notification text — fades in over the title, in the volume orange
            Text {
                anchors.centerIn: parent
                width: parent.width - 20
                text: Notif.NotificationService.text
                color: Theme.Colors.barVolumeFill
                font.pixelSize: 14
                font.bold: true
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
                opacity: Notif.NotificationService.active ? 1 : 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
            }

            // Now playing — transport controls plus the track, fading in
            // over the title whenever something is playing.
            Media.MediaControls {
                anchors.centerIn: parent
                maxTextWidth: parent.width - 140
                opacity: (Media.MprisService.active && !Notif.NotificationService.active) ? 1 : 0
                enabled: Media.MprisService.active && !Notif.NotificationService.active

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }

        // Volume meter: chevron-shaped, fills with the level.
        // Scroll to change, left-click to mute. Paints its own slanted
        // ends so it doubles as the separator into the date section.
        BarUtils.VolumeWedge {
            id: volWedge
            Layout.preferredWidth: implicitWidth
            Layout.fillHeight: true
            leftColor: Theme.Colors.barBackground
            rightColor: Theme.Colors.barDateBackground
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
                    return `${day}/${month}/${year}`;
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
