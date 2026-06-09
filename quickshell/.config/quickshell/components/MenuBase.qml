import "../res"
import QtQuick
import Quickshell

PopupWindow {
    id: menuBase

    function open(x, y) {
        anchor.rect.x = x;
        anchor.rect.y = y;
        slideTranslate.y = Settings.panelIsAtTop ? -menuBase.height : menuBase.height;
        menuBase.visible = true;
        openAnim.start();
    }

    function close() {
        openAnim.stop();
        closeAnim.to = Settings.panelIsAtTop ? -menuBase.height : menuBase.height;
        closeAnim.start();
    }

    color: "transparent"
    anchor.window: panel
    anchor.rect.x: parentWindow.width / 2 - width / 2
    anchor.rect.y: parentWindow.height
    anchor.edges: Settings.panelIsAtTop ? Edges.Bottom : Edges.Top
    anchor.gravity: Settings.panelIsAtTop ? Edges.Bottom : Edges.Top
    visible: false
    grabFocus: true

    Translate {
        id: slideTranslate
        y: 0
    }

    Component.onCompleted: contentItem.transform = [slideTranslate]

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
            if (Settings.panelIsAtTop) {
                // rounded bottom corners
                ctx.moveTo(0, 0);
                ctx.lineTo(width, 0);
                ctx.lineTo(width, height - r);
                ctx.arcTo(width, height, width - r, height, r);
                ctx.lineTo(r, height);
                ctx.arcTo(0, height, 0, height - r, r);
            } else {
                // rounded top corners
                ctx.moveTo(0, r);
                ctx.arcTo(0, 0, r, 0, r);
                ctx.lineTo(width - r, 0);
                ctx.arcTo(width, 0, width, r, r);
                ctx.lineTo(width, height);
                ctx.lineTo(0, height);
            }
            ctx.closePath();
            ctx.fillStyle = bgColor;
            ctx.fill();
        }
    }

}
