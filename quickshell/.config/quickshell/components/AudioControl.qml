import "../res"
import QtQuick
import Quickshell.Services.Pipewire

Text {
    id: audioControl

    readonly property string volumeIcon: {
        if (volumeControl.muted)
            return " ";

        if (volumeControl.volume < 30)
            return " ";

        if (volumeControl.volume < 70)
            return " ";

        return " ";
    }

    color: GlobalColors.primary
    font.pointSize: GlobalFont.fontSize
    font.family: GlobalFont.fontFamily
    text: volumeIcon + " " + volumeControl.volume + "%"

    Item {
        id: volumeControl

        property PwNode audioSink: Pipewire.defaultAudioSink
        property int volume: {
            if (volumeControl.audioSink)
                return Math.floor(volumeControl.audioSink.audio.volume * 100);

            return 0;
        }
        property bool muted: {
            if (volumeControl.audioSink)
                return volumeControl.audioSink.audio.muted;

            return true;
        }

        PwObjectTracker {
            objects: [volumeControl.audioSink]
        }

    }

    MouseArea {
        anchors.fill: parent
        onWheel: (wheel) => {
            if (!volumeControl.audioSink)
                return ;

            var newVolume = volumeControl.audioSink.audio.volume + (wheel.angleDelta.y > 0 ? 0.01 : -0.01);
            console.log("Wheel modifiers: " + wheel.modifiers);
            if (wheel.modifiers & Qt.ShiftModifier) {
                newVolume = Math.round(newVolume * 20) / 20; // Round to nearest 5%
                console.log("Rounded volume to nearest 5%: " + newVolume);
            }
            newVolume = Math.max(0, Math.min(1, newVolume)); // Clamp between 0 and 1
            volumeControl.audioSink.audio.volume = newVolume;
        }
        onClicked: function() {
            if (!volumeControl.audioSink)
                return ;

            volumeControl.audioSink.audio.muted = !volumeControl.audioSink.audio.muted;
        }
    }

}
