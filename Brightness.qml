// Brightness.qml

pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    // --- API publique --------------------------------------------------
    readonly property real percentage: maxBrightness > 0
        ? (currentBrightness / maxBrightness) * 100
        : 0

    // --- État interne (ne pas lire depuis l'extérieur) ------------------
    property string devicePath: ""
    property int currentBrightness: 0
    property int maxBrightness: 1
    property bool maxLoaded: false
    property bool currentLoaded: false
    readonly property bool ready: maxLoaded && currentLoaded

    Component.onCompleted: detectDevice.running = true

    Process {
        id: detectDevice
        command: ["ls", "/sys/class/backlight"]
        stdout: StdioCollector {
            onStreamFinished: {
                const device = text.trim().split("\n")[0];
                if (!device) {
                    console.warn("Brightness: aucun périphérique dans /sys/class/backlight (ddcutil ?)");
                    return;
                }
                root.devicePath = "/sys/class/backlight/" + device;
                maxBrightnessFile.path = root.devicePath + "/max_brightness";
                brightnessFile.path = root.devicePath + "/actual_brightness";
            }
        }
    }

    FileView {
        id: maxBrightnessFile
        onLoaded: {
            root.maxBrightness = parseInt(text().trim()) || 1;
            root.maxLoaded = true;
        }
    }

    FileView {
        id: brightnessFile
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            root.currentBrightness = parseInt(text().trim()) || 0;
            root.currentLoaded = true;
        }
    }
}
