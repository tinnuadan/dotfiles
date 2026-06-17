import "../res"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray

RowLayout {
    readonly property var systemTray: SystemTray

    Repeater {
        model: systemTray.items

        delegate: Image {
            source: modelData.icon
            Layout.preferredWidth: 18
            Layout.preferredHeight: Layout.preferredWidth
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: (mouse) => {
                  var pos = panelContent.calculateMenuPosition(parent);
                    menuAnchor.anchor.rect.x = pos.x;
                    menuAnchor.anchor.rect.y = pos.y;
                    if (mouse.button === Qt.RightButton && modelData.menu) {
                        menuAnchor.menu = modelData.menu;
                        menuAnchor.open();
                    } else {
                        modelData.activate();
                    }
                }
                // onPositionChanged: {
                //   if(containsMouse) {
                //     var pos = panelContent.calculateMenuPosition(parent);
                //     tooltip.open(pos.x, pos.y, "tooltup");
                //   } else {
                //     tooltip.close();
                //   }
                // }
            }
        }
    }

    QsMenuAnchor {
        id: menuAnchor
        anchor.window: panel
    }
}
