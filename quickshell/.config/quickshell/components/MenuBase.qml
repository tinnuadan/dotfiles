import "../res"
import QtQuick
import Quickshell

PopupWindow {
    id: menuBase

    function open(x, y) {
        console.log("Opening menu at: " + x + ", " + y);
        anchor.rect.x = x;
        anchor.rect.y = y;
        menuBase.visible = true;
    }

    color: "transparent"
    anchor.window: panel
    anchor.rect.x: parentWindow.width / 2 - width / 2
    anchor.rect.y: parentWindow.height
    visible: false
    grabFocus: true

    Canvas {
        anchors.fill: parent
        z: -1
        property color bgColor: GlobalColors.transparentBackground
        onBgColorChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            var r = 10;
            ctx.beginPath();
            ctx.moveTo(0, 0);
            ctx.lineTo(width, 0);
            ctx.lineTo(width, height - r);
            ctx.arcTo(width, height, width - r, height, r);
            ctx.lineTo(r, height);
            ctx.arcTo(0, height, 0, height - r, r);
            ctx.lineTo(0, 0);
            ctx.closePath();
            ctx.fillStyle = bgColor;
            ctx.fill();
        }
    }
}
