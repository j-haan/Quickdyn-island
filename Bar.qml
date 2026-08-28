import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick


Scope {

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      property real maxIslandHeight: 70

      exclusiveZone: 60
      implicitHeight: maxIslandHeight + 30
      color: "transparent"

      Connections {
        target: island
        function onImplicitHeightChanged() {
          if (island.implicitHeight > maxIslandHeight)
            maxIslandHeight = island.implicitHeight
        }
      }

      WlrLayershell.namespace: "quickshell:bar"

      mask: Region {
        x: island.x
        y: island.y
        width: island.width
        height: island.height
      }

      Island {
        id: island
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
      }
    }
  }
}
