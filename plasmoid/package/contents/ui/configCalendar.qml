/*
    SPDX-FileCopyrightText: 2015 Martin Klapetek <mklapetek@kde.org>

    SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
*/

import QtQuick 2.0
import QtQuick.Controls 2.4 as QtControls
import QtQuick.Layouts 1.0 as QtLayouts
import org.kde.plasma.calendar 2.0 as PlasmaCalendar
import org.kde.kirigami 2.5 as Kirigami

Item {
    id: calendarPage
    width: childrenRect.width
    height: childrenRect.height

    signal configurationChanged

    function saveConfig()
    {
        plasmoid.configuration.enabledCalendarPlugins = PlasmaCalendar.EventPluginsManager.enabledPlugins;
    }

    Kirigami.FormLayout {
        anchors {
            left: parent.left
            right: parent.right
        }

        QtLayouts.ColumnLayout {
            Kirigami.FormData.label: i18nd("plasma_applet_org.kde.plasma.digitalclock", "Available Plugins:")
            Kirigami.FormData.buddyFor: children[1] // 0 is the Repeater

            Repeater {
                id: calendarPluginsRepeater
                model: PlasmaCalendar.EventPluginsManager.model
                delegate: QtLayouts.RowLayout {
                    QtControls.CheckBox {
                        text: model.display
                        checked: model.checked
                        onClicked: {
                            //needed for model's setData to be called
                            model.checked = checked;
                            calendarPage.configurationChanged();
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        PlasmaCalendar.EventPluginsManager.populateEnabledPluginsList(plasmoid.configuration.enabledCalendarPlugins);
    }
}

