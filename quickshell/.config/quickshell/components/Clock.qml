import "../res"
import QtQuick

Text {
    id: clock

    readonly property string timeFormat: "hh:mm:ss"

    text: Qt.formatTime(new Date(), clock.timeFormat)
    color: GlobalColors.primary
    font.pointSize: GlobalFont.fontSize
    font.family: GlobalFont.fontFamily

    signal clicked

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.text = Qt.formatTime(new Date(), clock.timeFormat)
    }

    MouseArea {
        anchors.fill: parent
        onClicked: clock.clicked()
    }

}
