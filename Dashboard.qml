// Dashboard.qml - Center popup
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "Themes" as Theme
import "DashboardUtils" as Dash

Scope {
    WlrLayershell {
        id: dashboard
        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }
        layer: WlrLayer.Overlay
        visible: false
        color: "transparent"

        // toggle listener
        Process {
            command: ["bash", "-c", 
                "rm -f /tmp/qs-dashboard.fifo; mkfifo /tmp/qs-dashboard.fifo; while true; do cat /tmp/qs-dashboard.fifo; done"]
            running: true
            stdout: SplitParser {
                onRead: data => {
                    if (data.trim() === "toggle")
                        dashboard.visible = !dashboard.visible
                }
            }
        }

        // click-outside-to-close
        MouseArea {
            anchors.fill: parent
            onClicked: dashboard.visible = false

            Rectangle {
                id: dashboardSurface
                anchors.centerIn: parent
                width: Dash.Dimensions.dashWidth
                height: Dash.Dimensions.dashHeight
                color: Theme.Colors.color15
                radius: Dash.Dimensions.dashRadius
                border.width: Dash.Dimensions.dashBorderWidth
                border.color: Theme.Colors.color11

                // Eat clicks on empty border
                MouseArea {
                    anchors.fill: parent
                    onClicked: dashboard.visible = false
                    z: -1
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: Dash.Dimensions.dashPadding         
                    spacing: Dash.Dimensions.dashSpacing             
                    z: 0

                    // Icon bar at top
                    Dash.DashButtons {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Dash.Dimensions.btnSize + Dash.Dimensions.barVPadding * 2
                    }

                    // Contribution graph fills remaining space
                    Dash.ContribGraph {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumHeight: Dash.Dimensions.minGraphHeight
                    }
                }
            }
        }
    }
}