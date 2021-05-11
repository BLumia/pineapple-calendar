import QtQuick 2.1
import QtQuick.Layouts 1.1
import QtQml 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.components 3.0 as PlasmaComponents3

import "calendar" as LocalCalendar

PlasmaComponents3.Page {
    id: calendar
    anchors.fill: parent
    Layout.minimumWidth: units.gridUnit * 20
    Layout.minimumHeight: units.gridUnit * 20
    
    // Header containing date and pin button
    header: PlasmaExtras.PlasmoidHeading {
        id: headerArea

        RowLayout {
            width: parent.width

            PlasmaExtras.Heading {
                Layout.fillWidth: true
                Layout.leftMargin: calendar.paddings // Match calendar title

                level: 1

                text: monthView.currentDate.toLocaleDateString(Qt.locale(), Locale.LongFormat)
            }

            PlasmaComponents3.ToolButton {
                visible: plasmoid.action("configure").enabled
                icon.name: "configure"
                onClicked: plasmoid.action("configure").trigger()
                PlasmaComponents3.ToolTip {
                    text: plasmoid.action("configure").text
                }
            }

            // Allows the user to keep the calendar open for reference
            PlasmaComponents3.ToolButton {
                checkable: true
                checked: plasmoid.configuration.pin
                onToggled: plasmoid.configuration.pin = checked
                icon.name: "window-pin"
                PlasmaComponents3.ToolTip {
                    text: i18n("Keep Open")
                }
            }
            
            Binding {
                target: plasmoid
                property: "hideOnWindowDeactivate"
                value: !plasmoid.configuration.pin
                restoreMode: Binding.RestoreBinding
            }
        }
    }

    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 500
    }

    LocalCalendar.MonthView {
        id: monthView
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
