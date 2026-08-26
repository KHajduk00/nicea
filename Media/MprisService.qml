pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

// Surfaces whatever is currently playing on the bar, in place of the focused
// window title. Anything that speaks MPRIS works — a Firefox tab, the Spotify
// app, mpv — because these are D-Bus calls to the player itself, not service
// APIs. Silent about players that expose no track name.
Singleton {
    id: root

    // The player we follow: whichever is actually playing, else the first one
    // on the bus, else null when nothing is registered.
    readonly property var player: {
        const ps = Mpris.players.values;
        return ps.find(p => p.isPlaying) ?? ps[0] ?? null;
    }

    // "Title — Artist". YouTube channel names arrive as artists ("… - Topic",
    // "…VEVO") and its titles usually already name the artist, so the suffixes
    // are trimmed and a redundant artist is dropped rather than repeated.
    readonly property string text: {
        if (!player)
            return "";
        const title = player.trackTitle ?? "";
        const artist = (player.trackArtist ?? "").replace(/ - Topic$/, "").replace(/VEVO$/i, "").trim();
        const squash = (s) => s.toLowerCase().replace(/[^a-z0-9]/g, "");
        if (title && artist && !squash(title).includes(squash(artist)))
            return title + " — " + artist;
        return title || artist;
    }

    // True while there's a track worth showing — and worth controlling.
    readonly property bool active: player !== null && player.isPlaying && text !== ""

    function toggle() {
        if (root.player && root.player.canTogglePlaying)
            root.player.togglePlaying();
    }

    function next() {
        if (root.player && root.player.canGoNext)
            root.player.next();
    }

    function previous() {
        if (root.player && root.player.canGoPrevious)
            root.player.previous();
    }

}
