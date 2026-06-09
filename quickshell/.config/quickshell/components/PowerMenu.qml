import "."
import "../res"
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

MenuBase {
    id: powerMenu

    implicitWidth: 200

    Item {
        id: rect
        anchors.fill: parent
        anchors.margins: 10

        ColumnLayout {
            anchors.fill: parent
            // anchors.pa
            spacing: 5

            MenuButton {

                text: "󰐥  Shutdown"
                onClicked: {
                Hyprland.dispatch("poweroff")
                }
            }

            MenuButton {
                // Hyprland.dispatch("hyprctl reload")

                text: "  Restart"
                onClicked: {
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
