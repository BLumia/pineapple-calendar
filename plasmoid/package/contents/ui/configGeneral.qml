import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.4 as Kirigami
import org.kde.kirigamiaddons.labs.mobileform 0.1 as MobileForm

Item {
    id: page

    property alias cfg_fontPixelSize: fontPixelSize.value
    property alias cfg_datetimeFormat: datetimeFormatLabel.text
    property alias cfg_enableDesktopPeeker: enableDesktopPeeker.checked
    property alias cfg_peekerWidth: peekerWidth.value

    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        MobileForm.FormCard {
            Layout.fillWidth: true
            contentItem: ColumnLayout {
                spacing: 0
                MobileForm.FormCardHeader {
                    title: i18n("Panel")
                }

                MobileForm.AbstractFormDelegate {
                    Layout.fillWidth: true
                    contentItem: RowLayout {
                        Label {
                            text: i18n("Font size")
                            Layout.fillWidth: true
                        }
                        SpinBox {
                            id: fontPixelSize
                        }
                    }
                }

                MobileForm.AbstractFormDelegate {
                    Layout.fillWidth: true
                    contentItem: RowLayout {
                        Label {
                            text: i18n("Datetime display format")
                            Layout.fillWidth: true
                        }
                        TextArea {
                            id: datetimeFormatLabel
                            placeholderText: "h:mm\\nyyyy/MM/dd"
                        }
                    }
                }
            }
        }

        MobileForm.FormCard {
            Layout.fillWidth: true
            contentItem: ColumnLayout {
                spacing: 0
                MobileForm.FormCardHeader {
                    title: i18n("Desktop Peeker")
                }

                MobileForm.FormSwitchDelegate {
                    id: enableDesktopPeeker
                    text: i18n("Show desktop peeker")
                }

                MobileForm.AbstractFormDelegate {
                    Layout.fillWidth: true
                    contentItem: RowLayout {
                        Label {
                            text: i18n("Peeker width")
                            Layout.fillWidth: true
                        }
                        SpinBox {
                            id: peekerWidth
                            from: 1
                            to: 50
                        }
                    }
                }
            }
        }
    }
}
