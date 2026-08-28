pragma Singleton

import Quickshell
import Quickshell.Services.Mpris
import QtQuick

Singleton {
    id: root

    readonly property var activePlayer: {
        const players = Mpris.players.values;
        for (let i = 0; i < players.length; i++) {
            if (players[i].playbackState === MprisPlaybackState.Playing) return players[i];
        }
        return players.length > 0 ? players[0] : null;
    }

    readonly property bool hasActivePlayer: activePlayer !== null
    readonly property bool playing: hasActivePlayer && activePlayer.playbackState === MprisPlaybackState.Playing
    readonly property string title: hasActivePlayer ? (activePlayer.trackTitle || "") : ""
    readonly property string artist: hasActivePlayer ? (activePlayer.trackArtist || "") : ""
    readonly property string artUrl: hasActivePlayer ? (activePlayer.trackArtUrl || "") : ""
    readonly property real position: hasActivePlayer ? activePlayer.position : 0
    readonly property real length: hasActivePlayer ? activePlayer.length : 0

    Timer {
        interval: 1000
        repeat: true
        running: root.playing
        onTriggered: if (root.activePlayer) root.activePlayer.positionChanged()
    }
}
