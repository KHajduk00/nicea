// Bar.qml - Top bar
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import Qt5Compat.GraphicalEffects

import "Themes" as Theme

PanelWindow {
  id: bar
  
  anchors {
    top: true
    left: true
    right: true
  }
  
  implicitHeight: 30
  color: Theme.Colors.color15
  
  // Time Clock
  Text {
    id: clockText    
    property var date: new Date()
    
    Timer {
      running: true
      repeat: true
      interval: 1000
      onTriggered: clockText.date = new Date()
    }
    
    text: {
      const hours = clockText.date.getHours().toString().padStart(2, '0');
      const minutes = clockText.date.getMinutes().toString().padStart(2, '0');
      return `${hours}:${minutes}`
    }
    
    anchors.right: parent.right
    anchors.rightMargin: 10
    anchors.verticalCenter: parent.verticalCenter
    color: Theme.Colors.color0
    font.pixelSize: 16
  }
  
  // Internet connectivity indicator
  Item {                 
      anchors.left: parent.left
      anchors.leftMargin: 10
      anchors.verticalCenter: parent.verticalCenter
      width: 25; height: 25

      QtObject {
          id: internetModule
          property bool internetConnected: false
      }

      Process {
          id: internetProcess
          running: true
          command: ["ping", "-c1", "1.0.0.1"]
          property string fullOutput: ""
          stdout: SplitParser {
              onRead: out => {
                  internetProcess.fullOutput += out + "\n";
                  if (out.includes("0% packet loss")) internetModule.internetConnected = true;
              }
          }
          onExited: {
              internetModule.internetConnected = internetProcess.fullOutput.includes("0% packet loss");
              internetProcess.fullOutput = "";
              updateTimer.restart();
          }
      }

      Timer {
          id: updateTimer
          interval: 5000
          running: true; repeat: true
          onTriggered: {
              internetModule.internetConnected = false;
              internetProcess.running = true;
          }
      }

      Image {
          anchors.fill: parent
          source: internetModule.internetConnected
                  ? "/home/khajduk/.config/quickshell/nicea/icons/yes-internet.svg"
                  : "/home/khajduk/.config/quickshell/nicea/icons/no-internet.svg"
          fillMode: Image.PreserveAspectFit
          smooth: true
      }
  }

  // Workspace indicators
  Row {
    anchors.centerIn: parent
    spacing: 8

    Repeater {
      model: Hyprland.workspaces

      delegate: Item {
        width: 22
        height: 22

        Image { 
          id: wsIcon
          anchors.fill: parent
          source: modelData.active
                    ? "/home/khajduk/.config/quickshell/nicea/icons/circle-selected.svg"
                    : "/home/khajduk/.config/quickshell/nicea/icons/circle-empty.svg"
          fillMode: Image.PreserveAspectFit
          smooth: true
        }
        
        ColorOverlay {
                anchors.fill: wsIcon
                source: wsIcon
                color: modelData.active ? Theme.Colors.color0   // highlighted
                                        : Theme.Colors.color7
        }
      }
    }
  }
}