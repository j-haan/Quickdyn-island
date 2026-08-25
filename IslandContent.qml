// IslandContent.qml

import QtQuick

Item {
    id: root

    property string mode: "clock" // "clock" | "brightness" | "volume"

    implicitWidth: {
        if (mode === "brightness") return brightness.implicitWidth;
        if (mode === "volume") return volume.implicitWidth;
        return clock.implicitWidth;
    }
    implicitHeight: {
        if (mode === "brightness") return brightness.implicitHeight;
        if (mode === "volume") return volume.implicitHeight;
        return clock.implicitHeight;
    }

    ClockWidget {
        id: clock
        anchors.centerIn: parent
        opacity: root.mode === "clock" ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }

    BrightnessIndicator {
        id: brightness
        anchors.centerIn: parent
        opacity: root.mode === "brightness" ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }

    VolumeIndicator {
        id: volume
        anchors.centerIn: parent
        opacity: root.mode === "volume" ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }

    Connections {
        target: Brightness
        function onPercentageChanged() {
            if (!Brightness.ready) return;
            root.mode = "brightness";
            revertTimer.restart();
        }
    }

    Connections {
        target: Volume
        function onPercentageChanged() {
            if (!Volume.ready) return;
            root.mode = "volume";
            revertTimer.restart();
        }
    }

    Timer {
        id: revertTimer
        interval: 2000
        onTriggered: root.mode = "clock"
    }
}
