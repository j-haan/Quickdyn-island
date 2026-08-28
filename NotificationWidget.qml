// NotificationWidget.qml
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    spacing: 8

    readonly property var notif: Notifications.latest
    readonly property bool hasImage: notif !== null && notif.image !== ""

    Image {
        visible: root.hasImage
        Layout.preferredWidth: 20
        Layout.preferredHeight: 20
        Layout.alignment: Qt.AlignVCenter
        source: root.hasImage ? root.notif.image : ""
        fillMode: Image.PreserveAspectFit
    }

    Text {
        visible: !root.hasImage
        text: "\uf0f3"
        color: "#FFFFFF"
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        Layout.preferredWidth: 20
        Layout.alignment: Qt.AlignVCenter
    }

    Text {
        text: root.notif ? (root.notif.summary || root.notif.appName || "") : ""
        color: "#FFFFFF"
        font.family: "JetBrains Mono"
        elide: Text.ElideRight
        Layout.maximumWidth: 480
        Layout.alignment: Qt.AlignVCenter
    }
}
