import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.private.showdesktop 0.1

Item {
    id: mainWindow
    Layout.minimumWidth: textMetrics.width + (peeker.visible ? peeker.width : 0)
    Layout.minimumHeight: 16

    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 500
    }

    readonly property ShowDesktop showdesktop: ShowDesktop {
        id: showdesktop
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Text {
            id: time
            Layout.fillWidth: true
            Layout.fillHeight: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: theme.textColor
            font.pixelSize: plasmoid.configuration.fontPixelSize
            text: Qt.formatDateTime(
                dataSource.data["Local"]["DateTime"],
                plasmoid.configuration.datetimeFormat
            )

            TextMetrics {
                id: textMetrics
                font.family: time.font.family
                font.pointSize: time.font.pointSize
                text: time.text
            }

            MouseArea {
                anchors.fill: parent
                onClicked: plasmoid.expanded = !plasmoid.expanded
            }
        }

        Control {
            id: peeker
            visible: plasmoid.configuration.enableDesktopPeeker
            Layout.fillHeight: true
            padding: 0
            spacing: 0
            implicitWidth: plasmoid.configuration.peekerWidth
            hoverEnabled: true

            background: Rectangle {
                opacity: peeker.hovered ? 0.16 : 0.08
                anchors.fill: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: showdesktop.toggleDesktop();
            }
        }
    }
}
