// IslandContent.qml

import QtQuick

Item {
    id: root

    property string mode: "clock" // "clock" | "brightness" | "volume" | "notification"

    implicitWidth: {
        if (mode === "brightness") return brightness.implicitWidth;
        if (mode === "volume") return volume.implicitWidth;
        if (mode === "notification") return notification.implicitWidth;
        return clock.implicitWidth;
    }
    implicitHeight: {
        if (mode === "brightness") return brightness.implicitHeight;
        if (mode === "volume") return volume.implicitHeight;
        if (mode === "notification") return notification.implicitHeight;
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

    NotificationWidget {
        id: notification
        anchors.centerIn: parent
        opacity: root.mode === "notification" ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }

    Connections {
        target: Brightness
        function onPercentageChanged() {
            if (!Brightness.ready) return;
            if (root.mode === "notification") return;
            root.mode = "brightness";
            revertTimer.interval = 2000;
            revertTimer.restart();
        }
    }

    Connections {
        target: Volume
        function onPercentageChanged() {
            if (!Volume.ready) return;
            if (root.mode === "notification") return;
            root.mode = "volume";
            revertTimer.interval = 2000;
            revertTimer.restart();
        }
    }

    Connections {
        target: Notifications
        function onLatestChanged() {
            root.mode = "notification";
            revertTimer.interval = 4000;
            revertTimer.restart();
        }
    }

    Timer {
        id: revertTimer
        interval: 2000
        onTriggered: root.mode = "clock"
    }
}
