//@ pragma UseQApplication

import "./components"
import "./res"
import QtQuick
import QtQuick.Controls.Imagine
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property var modelData

            screen: modelData
            anchors.top: Settings.panelIsAtTop
            anchors.bottom: !Settings.panelIsAtTop
            anchors.left: true
            anchors.right: true
            implicitHeight: Settings.panelHeight
            color: GlobalColors.transparentBackground

            // Container for panel content, used for mapping menu positions as PanelWindow is not a QQuickItem
            Item {
                id: panelContent

                function calculateMenuPosition(button) {
                    var x = button.mapToItem(panelContent, 0, 0).x;
                    var y = Settings.panelIsAtTop ? panelContent.height : 0;
                    return {
                        "x": x,
                        "y": y
                    };
                }

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

                    SysTray {
                        id: sysTray
                    }

                    AudioControl {
                        id: powerControlCenterButton
                    }

                    Clock {
                        id: clock

                        onClicked: {
                            var pos = panelContent.calculateMenuPosition(clock);
                            calendarContent.open(pos.x, pos.y);
                        }
                    }

                    MenuButton {
                        id: powerMenuButton

                        text: "󰐥 "
                        onClicked: {
                            var pos = panelContent.calculateMenuPosition(powerMenuButton);
                            powerMenuContent.open(pos.x, pos.y);
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

}
