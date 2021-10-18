import QtQuick 2.4
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: mainWindow
    Layout.minimumWidth: textMetrics.width
    Layout.minimumHeight: 16

    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 500
    }

    Text {
        id: time
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: theme.textColor
        font.pixelSize: plasmoid.configuration.fontPixelSize
        text: Qt.formatDateTime(
            dataSource.data["Local"]["DateTime"],
            plasmoid.configuration.datetimeFormat
        )
        anchors.fill: parent

        TextMetrics {
            id: textMetrics
            font.family: time.font.family
            font.pointSize: time.font.pointSize
            text: time.text
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: plasmoid.expanded = !plasmoid.expanded
    }
}
