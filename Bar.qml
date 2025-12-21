// Bar.qml
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
      left: true
      right: true
      top: Theme.Config.barTop
      bottom: Theme.Config.barBottom
  }
  
  height: 30  
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

        MouseArea {
            anchors.fill: parent
            onClicked: modelData.activate()
          }
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
                color: modelData.active ? Theme.Colors.color0
                                        : Theme.Colors.color7
        }
      }
    }
  }
}