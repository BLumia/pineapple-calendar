import QtQuick 2.13
import QtQuick.Layouts 1.1
import QtQuick.Window 2.13
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.components 3.0 as PlasmaComponents3

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

    PlasmaExtras.Representation {
        id: calendar
        anchors.fill: parent

        LocalCalendar.MonthView {
            width: parent.width / 2 - 1
            height: parent.height - calendarHeader.implicitHeight
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            today: new Date()//dataSource.data["Local"]["DateTime"]
        }

    }
}
