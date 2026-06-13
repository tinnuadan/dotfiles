import "../res"
import QtQuick

Text {
    id: menu

    signal clicked()

    color: mouseArea.containsMouse ? GlobalColors.accent : GlobalColors.primary
    font.pointSize: GlobalFont.fontSize
    font.family: GlobalFont.fontFamily
    text: "󰱨 "

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        onClicked: menu.clicked()
    }

}
