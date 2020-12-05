import QtQuick 2.13
import QtQuick.Window 2.13

import "calendar" as LocalCalendar

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Standalone Plasma Calendar Fork (test)")

    Rectangle {
        color: "#888"
        anchors.fill: parent
    }

    LocalCalendar.MonthView {
        anchors.fill: parent

        today: new Date()//dataSource.data["Local"]["DateTime"]
    }
}
