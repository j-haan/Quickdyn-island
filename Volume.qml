// Volume.qml

pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink

    // --- API publique --------------------------------------------------
    readonly property real percentage: ready ? sink.audio.volume * 100 : 0
    readonly property bool muted: ready ? sink.audio.muted : false
    readonly property bool ready: sink !== null && sink.ready && sink.audio !== null

    PwObjectTracker {
        objects: [root.sink]
    }
}
