import QtQuick 2.13
import QtQuick.Window 2.13
import org.kde.plasma.core 2.0 as PlasmaCore

import "calendar" as LocalCalendar

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Standalone Plasma Calendar Fork (test)")

    Rectangle {
        color: PlasmaCore.Theme.backgroundColor
        anchors.fill: parent
    }

    LocalCalendar.MonthView {
        anchors.fill: parent

        today: new Date()//dataSource.data["Local"]["DateTime"]
    }
}
