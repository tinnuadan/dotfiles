import "../res"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

RowLayout {
    Repeater {
        model: Hyprland.workspaces

        delegate: Item {
            property bool hovered: false
            // Find the active window on this workspace, if any
            property var workspaceWindow: {
                let fallback = null;
                for (let i = 0; i < modelData.toplevels.values.length; i++) {
                    const win = modelData.toplevels.values[i];
                    if (!fallback)
                        fallback = win;

                    if (win.activated)
                        return win;

                }
                return fallback;
            }
            property string appId: workspaceWindow && workspaceWindow.wayland ? workspaceWindow.wayland.appId : ""
            property var desktopEntry: appId !== "" ? DesktopEntries.heuristicLookup(appId) : null
            property string iconName: desktopEntry && desktopEntry.icon ? desktopEntry.icon : appId

            visible: modelData.monitor !== null && modelData.monitor.name === panel.screen.name
            implicitWidth: GlobalFont.fontSize * 2.2
            implicitHeight: GlobalFont.fontSize * 2.2

            IconImage {
                id: workspaceIcon

                anchors.centerIn: parent
                implicitSize: GlobalFont.fontSize * 1.6
                visible: iconName !== ""
                source: Quickshell.iconPath(iconName, "application-x-executable")
                opacity: modelData.focused ? 1 : 0.65
            }

            Text {
                id: workspaceNumberOverlay

                anchors.right: parent.right
                anchors.bottom: parent.bottom
                text: modelData.name
                visible: workspaceIcon.visible
                color: {
                    if (hovered)
                        return GlobalColors.highlight;

                    return modelData.focused ? GlobalColors.accent : GlobalColors.primary;
                }
                font.pointSize: GlobalFont.smallFontSize
                font.family: GlobalFont.fontFamily
                // font.bold: hovered || modelData.focused
                // Helps readability over icons
                style: Text.Outline
                styleColor: GlobalColors.background
            }

            Text {
                id: workspaceNumber

                anchors.centerIn: parent
                text: modelData.name
                visible: !workspaceIcon.visible
                color: {
                    if (hovered)
                        return GlobalColors.highlight;

                    return modelData.focused ? GlobalColors.accent : GlobalColors.primary;
                }
                font.pointSize: GlobalFont.fontSize
                font.family: GlobalFont.fontFamily
                // font.bold: hovered || modelData.focused
                // Helps readability over icons
                // style: Text.Outline
                // styleColor: GlobalColors.background
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.hovered = true
                onExited: parent.hovered = false
                onClicked: Hyprland.dispatch("workspace " + modelData.id)
            }

        }

    }

}
