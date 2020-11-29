import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    anchors.fill: parent
    PlasmaComponents.Label {
        Layout.alignment: Qt.AlignCenter
        text: plasmoid.nativeInterface.nativeText ? plasmoid.nativeInterface.nativeText : "Calendar"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: plasmoid.expanded = !plasmoid.expanded
    }
}