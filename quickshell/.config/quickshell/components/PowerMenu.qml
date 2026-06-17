import "."
import "../res"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

MenuBase {
    id: powerMenu

    implicitWidth: 200

    Process {
        id: powerProcess

        running: false
    }

    Item {
        id: rect

        anchors.fill: parent
        anchors.margins: 10

        ColumnLayout {
            anchors.fill: parent
            spacing: 5

            MenuButton {
                text: "󰐥  Shutdown"
                onClicked: {
                    powerProcess.command = ["systemctl", "poweroff"];
                    powerProcess.running = true;
                }
            }

            MenuButton {
                text: "  Restart"
                onClicked: {
                    powerProcess.command = ["systemctl", "reboot"];
                    powerProcess.running = true;
                }
            }

            MenuButton {
                // Hyprland.dispatch("systemctl suspend")

                text: "󰤄  Sleep"
                onClicked: {
                }
            }

        }

    }

}
