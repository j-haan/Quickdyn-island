pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root

    readonly property bool ready: UPower.displayDevice.ready
    readonly property real percentage: ready ? UPower.displayDevice.percentage * 100 : 0
    readonly property bool charging: ready && UPower.displayDevice.state === UPowerDeviceState.Charging
}
