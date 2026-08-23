// IslandContent.qml

import QtQuick

Item {
    id: root

    property bool showBrightness: false

    implicitWidth: showBrightness ? brightness.implicitWidth : clock.implicitWidth
    implicitHeight: showBrightness ? brightness.implicitHeight : clock.implicitHeight

    ClockWidget {
        id: clock
        anchors.centerIn: parent
        opacity: root.showBrightness ? 0 : 1
        Behavior on opacity {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }

    BrightnessIndicator {
        id: brightness
        anchors.centerIn: parent
        opacity: root.showBrightness ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }

    Connections {
        target: Brightness
        function onPercentageChanged() {
            if (!Brightness.ready) return; // ignore la lecture initiale
            root.showBrightness = true;
            revertTimer.restart();
        }
    }

    Timer {
        id: revertTimer
        interval: 2000
        onTriggered: root.showBrightness = false
    }
}
