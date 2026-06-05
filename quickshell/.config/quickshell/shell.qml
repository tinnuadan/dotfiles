import "./components"
import "./res"
import QtQuick
import QtQuick.Controls.Imagine
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

ShellRoot {

    PanelWindow {
        id: panel

        anchors.top: Settings.panelIsAtTop
        anchors.bottom: !Settings.panelIsAtTop
        anchors.left: true
        anchors.right: true
        implicitHeight: Settings.panelHeight
        color: Qt.rgba(54 / 255, 58 / 255, 79 / 255, 0.7)

        RowLayout {
            id: leftItems

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10

            Workspaces {
                id: workspaces
            }

        }

        ActiveWindow {
            id: activeWindow

            anchors.centerIn: parent
        }

        RowLayout {
            id: rightItems

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            spacing: 15

            Clock {
                id: clock
                onClicked: {
                    var x = mapToGlobal(Qt.point(0, clock.height)).x;
                    var y = panel.height;
                    calendarContent.open(x, y);
                }
            }

            MenuButton {
                id: powerMenuButton

                text: "󰐥 "
                onClicked: {
                    var x = mapToGlobal(Qt.point(0, powerMenuButton.height)).x;
                    var y = panel.height; //mapToGlobal(Qt.point(0, panel.height)).y;
                    console.log("Opening menu at: " + x + ", " + y);
                    powerMenuContent.open(x, y);
                }
            }
        }

        PowerMenu {
            id: powerMenuContent
            anchor.window: panel
        }

        Calendar {
            id: calendarContent
            anchor.window: panel
        }

    }

}
