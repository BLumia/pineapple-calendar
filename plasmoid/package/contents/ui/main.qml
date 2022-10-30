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
    id: root

    Plasmoid.compactRepresentation: CompactRepresentation {}
    Plasmoid.fullRepresentation: CalendarView {} // with agenda
    //Plasmoid.fullRepresentation: FullRepresentation {} // just a calendar

    function initTimezones() {
        var tz  = Array()
        if (plasmoid.configuration.selectedTimeZones.indexOf("Local") === -1) {
            tz.push("Local");
        }
        root.allTimezones = tz.concat(plasmoid.configuration.selectedTimeZones);
    }

    function nameForZone(zone) {
        //add the timezone string to the clock
        var timezoneString = plasmoid.configuration.displayTimezoneAsCode ? dataSource.data[zone]["Timezone Abbreviation"]
                                                                          : TimezonesI18n.i18nCity(dataSource.data[zone]["Timezone City"]);

        return timezoneString;
    }

    function timeForZone(zone) {
        var compactRepresentationItem = plasmoid.compactRepresentationItem;
        if (!compactRepresentationItem) {
            return "";
        }

        // get the time for the given timezone from the dataengine
        var now = dataSource.data[zone]["DateTime"];
        // get current UTC time
        var msUTC = now.getTime() + (now.getTimezoneOffset() * 60000);
        // add the dataengine TZ offset to it
        var dateTime = new Date(msUTC + (dataSource.data[zone]["Offset"] * 1000));

        var formattedTime = Qt.formatTime(dateTime/*, compactRepresentationItem.timeFormat*/);

        if (dateTime.getDay() !== dataSource.data["Local"]["DateTime"].getDay()) {
            formattedTime += " (" + Qt.formatDate(dateTime/*, compactRepresentationItem.dateFormat*/) + ")";
        }

        return formattedTime;
    }

    //We need Local to be *always* present, even if not disaplayed as
    //it's used for formatting in ToolTip.dateTimeChanged()
    property var allTimezones
    Connections {
        target: plasmoid.configuration
        function onSelectedTimeZonesChanged() { root.initTimezones(); }
    }

    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: allTimezones
        interval: plasmoid.configuration.showSeconds ? 1000 : 60000
        intervalAlignment: plasmoid.configuration.showSeconds ? PlasmaCore.Types.NoAlignment : PlasmaCore.Types.AlignToMinute
    }

    function action_clockkcm() {
        KCMShell.openSystemSettings("kcm_clock");
    }

    function action_formatskcm() {
        KCMShell.openSystemSettings("kcm_formats");
    }

    Component.onCompleted: {
        root.initTimezones();
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
