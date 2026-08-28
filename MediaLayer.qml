import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root
    spacing: 2

    function formatTime(seconds) {
        if (!seconds || seconds <= 0) return "0:00";
        const total = Math.floor(seconds);
        const m = Math.floor(total / 60);
        const s = total % 60;
        return m + ":" + (s < 10 ? "0" : "") + s;
    }

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
        spacing: 16


        Rectangle {
            Layout.preferredWidth: 80
            Layout.preferredHeight: 80
            radius: 10
            color: "#444444"
            clip: true

            Image {
                anchors.fill: parent
                visible: Media.hasActivePlayer && Media.artUrl !== ""
                source: Media.hasActivePlayer ? Media.artUrl : ""
                fillMode: Image.PreserveAspectCrop
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            Text {
                Layout.fillWidth: true
                Layout.maximumWidth: 200
                text: Media.hasActivePlayer ? Media.title : ""
                color: "#FFFFFF"
                font.family: "JetBrains Mono"
                font.bold: true
                font.pixelSize: 15
                elide: Text.ElideRight
            }

            Text {
                Layout.fillWidth: true
                Layout.maximumWidth: 200
                text: Media.hasActivePlayer ? Media.artist : ""
                color: "#AAAAAA"
                font.family: "JetBrains Mono"
                font.pixelSize: 13
                elide: Text.ElideRight
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: 16

        Text {
            text: root.formatTime(Media.position)
            color: "#AAAAAA"
            font.family: "JetBrains Mono"
            font.pixelSize: 12
        }

        Rectangle {
            id: track
            Layout.fillWidth: true
            Layout.preferredHeight: 4
            radius: height / 2
            color: "#33FFFFFF"

            Rectangle {
                height: parent.height
                radius: parent.radius
                color: "#FFFFFF"
                width: Media.length > 0 ? track.width * Math.max(0, Math.min(1, Media.position / Media.length)) : 0

                Behavior on width {
                    NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                }
            }
        }

        Text {
            text: root.formatTime(Media.length)
            color: "#AAAAAA"
            font.family: "JetBrains Mono"
            font.pixelSize: 12
        }
    }
}
