import QtQuick

Item {
    id: root

    readonly property bool showNotification: islandContentRef.mode === "notification"

    property var islandContentRef

    implicitWidth: 500
    implicitHeight: (showNotification ? notificationLayer.implicitHeight : mediaLayer.implicitHeight) + 32
    MediaLayer {
        id: mediaLayer
        anchors.fill: parent
        anchors.margins: 16
        opacity: root.showNotification ? 0 : 1
        Behavior on opacity {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }

    NotificationLayer {
        id: notificationLayer
        anchors.fill: parent
        anchors.margins: 16
        opacity: root.showNotification ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }
}
