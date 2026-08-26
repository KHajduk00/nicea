import Qt5Compat.GraphicalEffects
import QtQuick
import "../Themes" as Theme

// Now-playing readout with transport controls, for the bar's center section.
// Buttons act on whatever MPRIS player MprisService is following, and grey out
// when that player says it can't honour them.
Row {
    id: root

    // Longest the track line may grow before eliding, so a long title never
    // shoves the buttons around.
    property real maxTextWidth: 400

    spacing: 6

    Repeater {
        model: [
            {
                "act": "prev",
                "icon": "media-prev.svg"
            },
            {
                "act": "toggle",
                "icon": ""
            },
            {
                "act": "next",
                "icon": "media-next.svg"
            }
        ]

        Item {
            id: btn
            width: 18
            height: 18
            anchors.verticalCenter: parent.verticalCenter
            scale: bma.containsMouse ? 0.9 : 1

            readonly property var player: MprisService.player
            readonly property bool playing: player !== null && player.isPlaying
            // Whether this particular control is available on this player.
            readonly property bool usable: {
                if (!player)
                    return false;
                if (modelData.act === "prev")
                    return player.canGoPrevious;
                if (modelData.act === "next")
                    return player.canGoNext;
                return player.canTogglePlaying;
            }

            Image {
                id: btnIcon
                anchors.centerIn: parent
                width: 14
                height: 14
                source: Theme.Config.iconsPath + "/" + (modelData.act === "toggle" ? (btn.playing ? "media-pause.svg" : "media-play.svg") : modelData.icon)
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            ColorOverlay {
                anchors.fill: btnIcon
                source: btnIcon
                color: !btn.usable ? Theme.Colors.barMediaDisabled : bma.containsMouse ? Theme.Colors.barMediaHover : Theme.Colors.barMediaText
            }

            MouseArea {
                id: bma
                anchors.fill: parent
                hoverEnabled: true
                enabled: btn.usable
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (modelData.act === "prev")
                        MprisService.previous();
                    else if (modelData.act === "next")
                        MprisService.next();
                    else
                        MprisService.toggle();
                }
            }

            Behavior on scale {
                NumberAnimation {
                    duration: 150
                }
            }
        }
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        width: Math.min(implicitWidth, root.maxTextWidth)
        text: MprisService.text
        color: Theme.Colors.barMediaText
        font.pixelSize: 14
        elide: Text.ElideRight
    }
}
