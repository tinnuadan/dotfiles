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
        color: GlobalColors.transparentBackground

        Item { // Container for panel content, used for mapping menu positions as PanelWindow is not a QQuickItem
            id: panelContent

            anchors.fill: parent

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

                MenuButton {
                    id: powerControlCenterButton

                    text: " "
                    onClicked: {
                        var x = powerControlCenterButton.mapToItem(panelContent, 0, 0).x;
                        var y = panelContent.height;
                        powerMenuContent.open(x, y);
                    }
                }

                Clock {
                    id: clock

                    onClicked: {
                        var x = clock.mapToItem(panelContent, 0, 0).x;
                        var y = panelContent.height;
                        calendarContent.open(x, y);
                    }
                }

                MenuButton {
                    id: powerMenuButton

                    text: "󰐥 "
                    onClicked: {
                        var x = powerMenuButton.mapToItem(panelContent, 0, 0).x;
                        var y = panelContent.height;
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

}
