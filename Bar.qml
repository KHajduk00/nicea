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