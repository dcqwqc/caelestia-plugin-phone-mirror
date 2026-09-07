import QtQuick
import qs.components.controls
import qs.services
import "../services" as PhoneMirror

// Quick toggle for the scrcpy mirror.
//
// The shell's built-in toggles borrow a private `Toggle` component inside
// Toggles.qml; a plugin cannot reach that, so the shape properties the loader
// reads -- fillWidth, shapeMorph -- are set here.
IconButton {
    // No handset configured yet: offer the pairing workflow rather than
    // pretending to be a switch over nothing.
    icon: PhoneMirror.Phone.configured ? "smartphone" : "phonelink_setup"
    checked: PhoneMirror.Phone.running || PhoneMirror.Phone.connecting
    isToggle: PhoneMirror.Phone.configured
    onClicked: PhoneMirror.Phone.toggle()

    inactiveColour: Colours.layer(Colours.palette.m3surfaceContainerHighest, 2)
    fillWidth: true
    isRound: true
    shapeMorph: true

    // Pairing happens in a terminal outside the shell, so re-read who the
    // handset is whenever this comes back on screen.
    onVisibleChanged: if (visible)
        PhoneMirror.Phone.refresh()
}
