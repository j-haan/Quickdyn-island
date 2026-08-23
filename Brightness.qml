// Brightness.qml

pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property real percentage: maxBrightness > 0
        ? (currentBrightness / maxBrightness) * 100
        : 0

    signal changed()

    property string devicePath: ""
    property int currentBrightness: 0
    property int maxBrightness: 1

    Component.onCompleted: detectDevice.running = true

    Process {
        id: detectDevice
        command: ["sh", "-c", "ls /sys/class/backlight | head -n1"]
        stdout: StdioCollector {
            onStreamFinished: {
                const device = text.trim();
                if (device.length === 0) {
                    console.warn("Brightness: aucun périphérique backlight trouvé dans /sys/class/backlight");
                    return;
                }
                root.devicePath = "/sys/class/backlight/" + device;
                readMax.running = true;
                brightnessFile.path = root.devicePath + "/actual_brightness";
            }
        }
    }

    Process {
        id: readMax
        command: ["cat", root.devicePath + "/max_brightness"]
        stdout: StdioCollector {
            onStreamFinished: root.maxBrightness = parseInt(text.trim()) || 1
        }
    }

    FileView {
        id: brightnessFile
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            root.currentBrightness = parseInt(text().trim()) || 0;
            root.changed();
        }
    }
}
