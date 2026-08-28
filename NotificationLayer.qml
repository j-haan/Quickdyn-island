import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root
    spacing: 2

    readonly property var notif: Notifications.latest
    readonly property bool hasImage: notif !== null && notif.image !== ""

    RowLayout {
        Layout.fillWidth: true
        spacing: 2
        Layout.alignment: Qt.AlignRight
        Text {
            Layout.alignment: Qt.AlignTop
            text: "\uf240 " + Math.round(Battery.percentage) + "%"
            color: "#FFFFFF"
            font.family: "JetBrains Mono"
            font.bold: true
        }
    }



    RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop
        spacing: 16

        Image {
            visible: root.hasImage
            Layout.preferredWidth: 40
            Layout.preferredHeight: 40
            Layout.alignment: Qt.AlignTop
            source: root.hasImage ? root.notif.image : ""
            fillMode: Image.PreserveAspectFit
        }

        Text {
            visible: !root.hasImage
            Layout.preferredWidth: 40
            Layout.alignment: Qt.AlignTop
            text: "\uf0f3"
            color: "#FFFFFF"
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            spacing: 4

            Text {
                Layout.fillWidth: true
                text: root.notif ? (root.notif.summary || root.notif.appName || "") : ""
                color: "#FFFFFF"
                font.family: "JetBrains Mono"
                font.bold: true
                font.pixelSize: 15
                wrapMode: Text.WordWrap
            }

            Text {
                visible: root.notif !== null && root.notif.body !== ""
                Layout.fillWidth: true
                textFormat: Text.PlainText
                text: root.notif ? root.notif.body : ""
                color: "#CCCCCC"
                font.family: "JetBrains Mono"
                font.pixelSize: 13
                wrapMode: Text.WordWrap
            }
        }
    }
}
