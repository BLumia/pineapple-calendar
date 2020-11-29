import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore

import "calendar" as LocalCalendar

Item {
    anchors.fill: parent
    Layout.minimumWidth: units.gridUnit * 20
    Layout.minimumHeight: units.gridUnit * 20

    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 500
    }

    LocalCalendar.MonthView {
        anchors.fill: parent

        today: dataSource.data["Local"]["DateTime"]
    }
}

// LocalCalendar.MonthView {
//     Layout.minimumWidth: units.gridUnit * 20
//     Layout.minimumHeight: units.gridUnit * 20
// }
// import org.kde.plasma.components 2.0 as PlasmaComponents

// ColumnLayout {
//     anchors.fill: parent
//     PlasmaComponents.Label {
//         Layout.alignment: Qt.AlignCenter
//         text: "Calendar"//plasmoid.nativeInterface.nativeText
//     }
// }