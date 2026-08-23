// BrightnessIndicator.qml

import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    spacing: 8

    Text {
        text: "\uf185"
        color: "#FFFFFF"
        font.pixelSize: 16
        Layout.alignment: Qt.AlignVCenter
    }

    Rectangle {
        id: track
        Layout.preferredWidth: 100
        Layout.preferredHeight: 6
        Layout.alignment: Qt.AlignVCenter
        radius: height / 2
        color: "#33FFFFFF"

        Rectangle {
            height: parent.height
            radius: parent.radius
            color: "#FFFFFF"
            width: track.width * Math.max(0, Math.min(100, Brightness.percentage)) / 100

            Behavior on width {
                NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
            }
        }
    }

    Text {
        text: Math.round(Brightness.percentage) + "%"
        color: "#FFFFFF"
        font.family: "JetBrains Mono"
        font.bold: true
        Layout.alignment: Qt.AlignVCenter
    }
}
