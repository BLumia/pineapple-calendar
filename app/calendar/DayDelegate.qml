/*
    SPDX-FileCopyrightText: 2013 Heena Mahour <heena393@gmail.com>
    SPDX-FileCopyrightText: 2013 Sebastian Kügler <sebas@kde.org>
    SPDX-FileCopyrightText: 2015 Kai Uwe Broulik <kde@privat.broulik.de>
    SPDX-FileCopyrightText: 2021 Jan Blackquill <uhhadd@gmail.com>
    SPDX-FileCopyrightText: 2021 Carl Schwan <carlschwan@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/
import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents2 // For Highlight
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras
import QtQml.Models 2.15

import net.blumia.pineapple.calendar 2.0
import net.blumia.calendar 0.1 as PCal

PlasmaComponents3.AbstractButton {
    id: dayStyle

    hoverEnabled: true
    property var dayModel: null

    signal activated

    readonly property date thisDate: new Date(yearNumber, typeof monthNumber !== "undefined" ? monthNumber - 1 : 0, typeof dayNumber !== "undefined" ? dayNumber : 1)
    readonly property bool today: {
        const today = root.today;
        let result = true;
        if (dateMatchingPrecision >= Calendar.MatchYear) {
            result = result && today.getFullYear() === thisDate.getFullYear()
        }
        if (dateMatchingPrecision >= Calendar.MatchYearAndMonth) {
            result = result && today.getMonth() === thisDate.getMonth()
        }
        if (dateMatchingPrecision >= Calendar.MatchYearMonthAndDay) {
            result = result && today.getDate() === thisDate.getDate()
        }
        return result
    }
    readonly property bool selected: {
        const current = root.currentDate;
        let result = true;
        if (dateMatchingPrecision >= Calendar.MatchYear) {
            result = result && current.getFullYear() === thisDate.getFullYear()
        }
        if (dateMatchingPrecision >= Calendar.MatchYearAndMonth) {
            result = result && current.getMonth() === thisDate.getMonth()
        }
        if (dateMatchingPrecision >= Calendar.MatchYearMonthAndDay) {
            result = result && current.getDate() === thisDate.getDate()
        }
        return result
    }

    PlasmaComponents2.Highlight {
        id: todayRect
        anchors.fill: parent
        opacity: {
            if (today) {
                return 1;
            } else if (selected) {
                return 0.6;
            } else if (dayStyle.hovered) {
                return 0.3;
            }
            return 0;
        }
    }

    Row {
        visible: false
        spacing: PlasmaCore.Units.smallSpacing
        anchors.bottom: parent.bottom
        anchors.bottomMargin: PlasmaCore.Units.smallSpacing
        anchors.horizontalCenter: parent.horizontalCenter
        Repeater {
            model: DelegateModel {
                model: dayStyle.dayModel
                rootIndex: modelIndex(index)
                delegate: Rectangle {
                    width: PlasmaCore.Units.smallSpacing * 1.5
                    height: width
                    radius: width / 2
                    color: eventColor || PlasmaCore.Theme.highlightColor
                }
            }
        }
    }

    contentItem: Column {
        spacing: 0 // PlasmaCore.Units.smallSpacing
        anchors.fill: parent
        anchors.bottomMargin: PlasmaCore.Units.smallSpacing * 3
        anchors.horizontalCenter: parent.horizontalCenter
        PlasmaExtras.Heading {
            id: label
            width: parent.width
            height: parent.height / (alternateLabel.visible ? 2 : 1)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: model.label || dayNumber
            opacity: isCurrent ? 1.0 : 0.5
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
            fontSizeMode: Text.HorizontalFit
        }
        PlasmaExtras.Heading {
            visible: model.label ? false : true
            id: alternateLabel
            width: parent.width
            height: parent.height / 2
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: model.label || PCal.CalendarUtils.alternateCalendarDayText(yearNumber, monthNumber, dayNumber)
            opacity: isCurrent ? 1.0 : 0.5
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
            fontSizeMode: Text.HorizontalFit
            font.pointSize: -1
        }
    }
}
