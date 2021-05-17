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

Item {
    Plasmoid.compactRepresentation: CompactRepresentation {}
    Plasmoid.fullRepresentation: CalendarView {} // with agenda
    //Plasmoid.fullRepresentation: FullRepresentation {} // just a calendar

    function action_clockkcm() {
        KCMShell.openSystemSettings("clock");
    }

    function action_formatskcm() {
        KCMShell.openSystemSettings("formats");
    }

    Component.onCompleted: {
        if (KCMShell.authorize("clock.desktop").length > 0) {
            plasmoid.setAction("clockkcm", i18nd("plasma_applet_org.kde.plasma.digitalclock", "Adjust Date and Time..."), "preferences-system-time");
        }
        if (KCMShell.authorize("formats.desktop").length > 0) {
            plasmoid.setAction("formatskcm", i18nd("plasma_applet_org.kde.plasma.digitalclock", "Set Time Format..."));
        }
    }
}
