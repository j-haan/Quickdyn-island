import QtQuick

Rectangle {
    id: root
    clip: true

    property bool isExpanded: false

    implicitWidth: isExpanded ? expanded.implicitWidth : (content.implicitWidth + 120)
    implicitHeight: isExpanded ? expanded.implicitHeight : Math.max(50, content.implicitHeight + 12)
    radius: isExpanded ? 28 : height / 2
    color: "#FF000000"

    Behavior on implicitWidth {
        NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
    }
    Behavior on implicitHeight {
        NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
    }
    Behavior on radius {
        NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
    }

    HoverHandler {
        id: hoverHandler
        onHoveredChanged: {
            if (hoverHandler.hovered) {
                exitDelay.stop();
                root.isExpanded = true;
            } else {
                exitDelay.restart();
            }
        }
    }

    Timer {
        id: exitDelay
        interval: 180
        onTriggered: root.isExpanded = false
    }

    IslandContent {
        id: content
        frozen: root.isExpanded
        anchors.centerIn: parent
        opacity: root.isExpanded ? 0 : 1
        Behavior on opacity {
            NumberAnimation { duration: 50; easing.type: Easing.OutCubic }
        }
    }

    ExpandedIsland {
        id: expanded
        islandContentRef: content
        anchors.centerIn: parent
        opacity: root.isExpanded ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 50; easing.type: Easing.OutCubic }
        }
    }
}
