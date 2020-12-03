import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

import QtQuick 2.4
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
    id: mainWindow
    //Layout.minimumWidth: Plasmoid.configuration.marginSize
    Layout.minimumWidth: textMetrics.width
    Layout.minimumHeight: 16
    property string textColor: Plasmoid.configuration.textColor
    property string textFont: Plasmoid.configuration.textFont

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
        font.weight: plasmoid.configuration.bold ? Font.Bold : Font.Normal
        color: theme.textColor
        font.pixelSize: plasmoid.configuration.clockFontSize
        text: Qt.formatDateTime( dataSource.data["Local"]["DateTime"],"h:mm\nyyyy/MM/dd" )
        anchors.fill: parent

        TextMetrics {
            id: textMetrics
            font.family: label.font.family
            font.pointSize: label.font.pointSize
            text: time.text
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: plasmoid.expanded = !plasmoid.expanded
    }
}
