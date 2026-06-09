import "../res"
import QtQuick
import Quickshell

PopupWindow {
    id: menuBase

    function open(x, y) {
        anchor.rect.x = x;
        anchor.rect.y = y;
        slideTranslate.y = -menuBase.height;
        menuBase.visible = true;
        openAnim.start();
    }

    function close() {
        closeAnim.to = -menuBase.height;
        closeAnim.start();
    }

    color: "transparent"
    anchor.window: panel
    anchor.rect.x: parentWindow.width / 2 - width / 2
    anchor.rect.y: parentWindow.height
    visible: false
    grabFocus: true

    Item {
        id: contentWrapper

        anchors.fill: parent

        NumberAnimation {
            id: openAnim

            target: slideTranslate
            property: "y"
            to: 0
            duration: 400
            easing.type: Easing.OutCubic
        }

        NumberAnimation {
            id: closeAnim

            target: slideTranslate
            property: "y"
            duration: 1000
            easing.type: Easing.InCubic
            onStopped: menuBase.visible = false
        }

        Canvas {
            property color bgColor: GlobalColors.transparentBackground

            anchors.fill: parent
            z: -1
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

        transform: Translate {
            id: slideTranslate

            y: 0
        }

    }

}
