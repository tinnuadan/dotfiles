import "."
import "../res"
import QtQuick
import QtQuick.Layouts

MenuBase {
    id: calendar

    width: 400
    height: 250

    function getISOWeek(date) {
        var d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
        var dayNum = d.getUTCDay() || 7;
        d.setUTCDate(d.getUTCDate() + 4 - dayNum);
        var yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
        return Math.ceil((((d - yearStart) / 86400000) + 1) / 7);
    }

    property var today: new Date()
    property int currentMonth: today.getMonth()
    property int currentYear: today.getFullYear()

    property var calendarCells: {
        var cells = [];
        var year = currentYear;
        var month = currentMonth;
        var todayDay = today.getDate();

        var firstDay = new Date(year, month, 1);
        var lastDay = new Date(year, month + 1, 0);
        var startDow = (firstDay.getDay() + 6) % 7; // 0=Mon, 6=Sun
        var endDow = (lastDay.getDay() + 6) % 7;
        var d = new Date(year, month, 1 - startDow);
        var endDate = new Date(year, month, lastDay.getDate() + (6 - endDow));

        while (d <= endDate) {
            cells.push({ text: "" + getISOWeek(d), isWeekNum: true, isToday: false });
            for (var i = 0; i < 7; i++) {
                var inMonth = d.getMonth() === month;
                cells.push({
                    text: inMonth ? "" + d.getDate() : "",
                    isWeekNum: false,
                    isToday: inMonth && d.getDate() === todayDay
                });
                d.setDate(d.getDate() + 1);
            }
        }
        return cells;
    }

    Item {
        anchors.fill: parent
        anchors.margins: 10

        ColumnLayout {
            anchors.fill: parent
            spacing: 4

            Text {
                Layout.fillWidth: true
                text: Qt.formatDate(calendar.today, "MMMM yyyy")
                color: GlobalColors.accent
                font.pointSize: GlobalFont.fontSize + 2
                font.family: GlobalFont.fontFamily
                horizontalAlignment: Text.AlignHCenter
                bottomPadding: 4
            }

            GridLayout {
                Layout.fillWidth: true
                columns: 8
                rowSpacing: 4
                columnSpacing: 0

                Repeater {
                    model: [" ", "Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]

                    Text {
                        Layout.fillWidth: true
                        text: modelData
                        color: GlobalColors.primary
                        font.pointSize: GlobalFont.fontSize
                        font.family: GlobalFont.fontFamily
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Repeater {
                    model: calendar.calendarCells

                    Text {
                        Layout.fillWidth: true
                        text: modelData.text
                        color: modelData.isToday ? GlobalColors.accent : GlobalColors.primary
                        font.pointSize: GlobalFont.fontSize
                        font.family: GlobalFont.fontFamily
                        font.bold: modelData.isToday
                        horizontalAlignment: Text.AlignHCenter
                        opacity: modelData.isWeekNum ? 0.4 : 1.0
                    }
                }
            }
        }
    }
}
