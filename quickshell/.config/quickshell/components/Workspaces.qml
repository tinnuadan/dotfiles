import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import "../res"

RowLayout {
  Repeater {
    model: Hyprland.workspaces
    delegate: Text {
      visible: modelData.monitor !== null && modelData.monitor.name === panel.screen.name
      property bool hovered: false
      text: modelData.name
      color: {
        if(hovered) return GlobalColors.highlight
        return modelData.focused ? GlobalColors.accent : GlobalColors.primary
      }
      font.pointSize: GlobalFont.fontSize
      font.family: GlobalFont.fontFamily
      font.bold: hovered

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