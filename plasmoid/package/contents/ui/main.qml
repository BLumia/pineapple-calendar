/*
    SPDX-FileCopyrightText: 2020 Gary Wang <wzc782970009@gmail.com>
    SPDX-License-Identifier: LGPL-2.1-or-later
*/

import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.kquickcontrolsaddons 2.0 // For KCMShell
import org.kde.plasma.calendar 2.0 as PlasmaCalendar

Item {
    Plasmoid.compactRepresentation: CompactRepresentation {}
    Plasmoid.fullRepresentation: CalendarView {} // with agenda
    //Plasmoid.fullRepresentation: FullRepresentation {} // just a calendar

    function action_clockkcm() {
        KCMShell.openSystemSettings("kcm_clock");
    }

    function action_formatskcm() {
        KCMShell.openSystemSettings("kcm_formats");
    }

    Component.onCompleted: {
        if (KCMShell.authorize("kcm_clock.desktop").length > 0) {
            plasmoid.setAction("clockkcm", i18nd("plasma_applet_org.kde.plasma.digitalclock", "Adjust Date and Time…"), "clock");
        }
        if (KCMShell.authorize("kcm_formats.desktop").length > 0) {
            plasmoid.setAction("formatskcm", i18nd("plasma_applet_org.kde.plasma.digitalclock", "Set Time Format…"), "gnumeric-format-thousand-separator");
        }

        // Set the list of enabled plugins from config
        // to the manager
        PlasmaCalendar.EventPluginsManager.enabledPlugins = plasmoid.configuration.enabledCalendarPlugins;
    }
}
