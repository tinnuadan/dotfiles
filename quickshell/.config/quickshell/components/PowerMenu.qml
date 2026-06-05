import "."
import "../res"
import QtQuick
import QtQuick.Layouts

MenuBase {
    id: powerMenu

    width: 200

    Item {
        id: rect
        anchors.fill: parent
        anchors.margins: 10

        ColumnLayout {
            anchors.fill: parent
            // anchors.pa
            spacing: 5

            MenuButton {
                // Hyprland.dispatch("hyprctl shutdown")

                text: "󰐥  Shutdown"
                onClicked: {
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
