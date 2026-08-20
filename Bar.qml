// Bar.qml
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

      implicitHeight: 60
      color: "transparent"


      WlrLayershell.namespace: "quickshell:bar"

      Rectangle {
        id: pill
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        implicitHeight: 50
        implicitWidth: clock.implicitWidth + 120
        radius: height / 2
        color: "#FF000000"

        ClockWidget {
            id: clock
            anchors.centerIn: parent

        }
      }
    }
  }
}
