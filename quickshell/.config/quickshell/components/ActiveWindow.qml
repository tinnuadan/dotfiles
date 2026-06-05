import "../res"
import QtQuick
import Quickshell.Hyprland

Text {
    text: Hyprland.activeToplevel && Hyprland.activeToplevel.title.length > 0 ? Hyprland.activeToplevel.title : "Desktop"
    color: GlobalColors.accent
    font.pointSize: GlobalFont.fontSize
    font.family: GlobalFont.fontFamily
}
