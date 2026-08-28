// Notifications.qml

pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property Notification latest: null

    NotificationServer {
        id: server
        keepOnReload: true

        actionsSupported: false
        bodySupported: true
        imageSupported: true

        onNotification: (notification) => {
            notification.tracked = true;
            root.latest = notification;
        }
    }
}
