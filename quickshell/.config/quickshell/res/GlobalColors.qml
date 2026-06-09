import "."
import QtQuick
pragma Singleton

QtObject {
    readonly property color primary: Macchiato.clrText
    readonly property color accent: Macchiato.sapphire
    readonly property color highlight: Macchiato.sky
    readonly property color background: Macchiato.surface0
    readonly property color transparentBackground: Qt.rgba(54 / 255, 58 / 255, 79 / 255, 0.75)
}
