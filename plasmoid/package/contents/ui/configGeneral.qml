import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami

Item {
    id: page

    property alias cfg_fontPixelSize: fontPixelSize.value
    property alias cfg_datetimeFormat: datetimeFormatLabel.text
    property alias cfg_enableDesktopPeeker: enableDesktopPeeker.checked
    property alias cfg_peekerWidth: peekerWidth.value

    Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        Item {
            Kirigami.FormData.label: "Panel"
            Kirigami.FormData.isSection: true
        }

        SpinBox {
            id: fontPixelSize
            Kirigami.FormData.label: "Font size:"
        }

        TextArea {
            id: datetimeFormatLabel
            Kirigami.FormData.label: "Datetime display format:"
            placeholderText: "h:mm\\nyyyy/MM/dd"
        }

        Item {
            Kirigami.FormData.label: "Desktop Peeker"
            Kirigami.FormData.isSection: true
        }

        CheckBox {
            id: enableDesktopPeeker
            Kirigami.FormData.label: "Show desktop peeker:"
        }

        SpinBox {
            id: peekerWidth
            from: 1
            to: 50
            Kirigami.FormData.label: "Peeker width:"
        }
    }
}
