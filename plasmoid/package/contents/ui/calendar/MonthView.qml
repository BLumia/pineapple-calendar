/*
    SPDX-FileCopyrightText: 2013 Heena Mahour <heena393@gmail.com>
    SPDX-FileCopyrightText: 2013 Sebastian Kügler <sebas@kde.org>
    SPDX-FileCopyrightText: 2015 Kai Uwe Broulik <kde@privat.broulik.de>

    SPDX-License-Identifier: GPL-2.0-or-later
*/
import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import org.kde.plasma.calendar 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

PinchArea {
    id: root

    anchors.fill: parent

    property alias selectedMonth: calendarBackend.monthName
    property alias selectedYear: calendarBackend.year
    property alias firstDayOfWeek: calendarBackend.firstDayOfWeek

    property QtObject date
    property date currentDate

    property date showDate: new Date()

    property int borderWidth: 1
    property real borderOpacity: 0.4

    property int columns: calendarBackend.days
    property int rows: calendarBackend.weeks

    property Item selectedItem
    property int week;
    property int firstDay: new Date(showDate.getFullYear(), showDate.getMonth(), 1).getDay()
    property alias today: calendarBackend.today
    property bool showWeekNumbers: false

    property alias cellHeight: mainDaysCalendar.cellHeight
    property QtObject daysModel: calendarBackend.daysModel

    onPinchStarted: stack.currentItem.transformOrigin = pinch.center
    onPinchUpdated: {
        var item = stack.currentItem
        if (stack.depth < 3 && pinch.scale < 1) {
            item.transformScale = pinch.scale
            item.opacity = pinch.scale
        } else if (stack.depth > 1 && pinch.scale > 1) {
            item.transformScale = pinch.scale
            item.opacity = (2 - pinch.scale / 2)
        }
    }
    onPinchFinished: {
        var item = stack.currentItem
        if (item.transformScale < 0.7) {
            item.headerClicked()
        } else if (item.transformScale > 1.4) {
            item.activateHighlightedItem()
        } else {
            item.transformScale = 1
            item.opacity = 1
        }
    }

    function isToday(date) {
        if (date.toDateString() == new Date().toDateString()) {
            return true;
        }

        return false;
    }

    function eventDate(yearNumber,monthNumber,dayNumber) {
        var d = new Date(yearNumber, monthNumber-1, dayNumber);
        return Qt.formatDate(d, "dddd dd MMM yyyy");
    }

    function resetToToday() {
        calendarBackend.resetToToday();
        root.currentDate = root.today;
        stack.pop(null);
    }

    function updateYearOverview() {
        var date = calendarBackend.displayedDate;
        var day = date.getDate();
        var year = date.getFullYear();

        for (var i = 0, j = monthModel.count; i < j; ++i) {
            monthModel.setProperty(i, "yearNumber", year);
        }
    }

    function updateDecadeOverview() {
        var date = calendarBackend.displayedDate;
        var day = date.getDate();
        var month = date.getMonth() + 1;
        var year = date.getFullYear();
        var decade = year - year % 10;

        for (var i = 0, j = yearModel.count; i < j; ++i) {
            var label = decade - 1 + i;
            yearModel.setProperty(i, "yearNumber", label);
            yearModel.setProperty(i, "label", label);
        }
    }

    Calendar {
        id: calendarBackend

        days: 7
        weeks: 6
        firstDayOfWeek: Qt.locale().firstDayOfWeek
        today: root.today

        Component.onCompleted: {
            daysModel.setPluginsManager(EventPluginsManager);
        }

        onYearChanged: {
            updateYearOverview()
            updateDecadeOverview()
        }
    }

    ListModel {
        id: monthModel

        Component.onCompleted: {
            for (var i = 0; i < 12; ++i) {
                append({
                    label: Qt.locale(Qt.locale().uiLanguages[0]).standaloneMonthName(i, Locale.LongFormat),
                    monthNumber: i + 1,
                    isCurrent: true
                })
            }
            updateYearOverview()
        }
    }

    ListModel {
        id: yearModel

        Component.onCompleted: {
            for (var i = 0; i < 12; ++i) {
                append({
                    isCurrent: (i > 0 && i < 11) // first and last year are outside the decade
                })
            }
            updateDecadeOverview()
        }
    }

    // NOTE: this MouseArea is a workaround on a PinchArea quirk:
    // When the pich is done spanning multiple child mouseareas it on't work:
    // a MouseArea on top of all the child mouseareas that just refuses events makes the pincharea work.
    // BUG: https://bugreports.qt.io/browse/QTBUG-76569
    MouseArea {
        anchors.fill: parent
        z: 1
        onPressed: mouse.accepted = false
    }

    StackView {
        id: stack

        anchors.fill: parent

        delegate: StackViewDelegate {
            pushTransition: StackViewTransition {
                NumberAnimation {
                    target: exitItem
                    duration: PlasmaCore.Units.longDuration
                    property: "opacity"
                    from: 1
                    to: 0
                }
                NumberAnimation {
                    target: enterItem
                    duration: PlasmaCore.Units.longDuration
                    property: "opacity"
                    from: 0
                    to: 1
                }
                NumberAnimation {
                    target: enterItem
                    duration: PlasmaCore.Units.longDuration
                    property: "transformScale"
                    from: 1.5
                    to: 1
                }
            }
            popTransition: StackViewTransition {
                NumberAnimation {
                    target: exitItem
                    duration: PlasmaCore.Units.longDuration
                    property: "opacity"
                    from: 1
                    to: 0
                }
                NumberAnimation {
                    target: exitItem
                    duration: PlasmaCore.Units.longDuration
                    property: "transformScale"
                    // so no matter how much you scaled, it would still fly towards you
                    to: exitItem.transformScale * 1.5
                }
                NumberAnimation {
                    target: enterItem
                    duration: PlasmaCore.Units.longDuration
                    property: "opacity"
                    from: 0
                    to: 1
                }
            }
        }

        initialItem: DaysCalendar {
            id: mainDaysCalendar
            title: calendarBackend.displayedDate.getFullYear() == new Date().getFullYear() ? root.selectedMonth :  root.selectedMonth + ", " + root.selectedYear

            columns: calendarBackend.days
            rows: calendarBackend.weeks

            showWeekNumbers: root.showWeekNumbers

            headerModel: calendarBackend.days
            gridModel: calendarBackend.daysModel

            dateMatchingPrecision: Calendar.MatchYearMonthAndDay

            previousLabel: i18nd("libplasma5", "Previous Month")
            nextLabel: i18nd("libplasma5", "Next Month")

            onPrevious: calendarBackend.previousMonth()
            onNext: calendarBackend.nextMonth()
            onHeaderClicked:  {
                stack.push(yearOverview)
            }
            onActivated: {
                var rowNumber = Math.floor(index / columns);
                week = 1 + calendarBackend.weeksModel[rowNumber];
                root.currentDate = new Date(date.yearNumber, date.monthNumber - 1, date.dayNumber)
            }
        }
    }

    Component {
        id: yearOverview

        DaysCalendar {
            title: calendarBackend.displayedDate.getFullYear()
            columns: 3
            rows: 4

            dateMatchingPrecision: Calendar.MatchYearAndMonth

            gridModel: monthModel

            previousLabel: i18nd("libplasma5", "Previous Year")
            nextLabel: i18nd("libplasma5", "Next Year")

            onPrevious: calendarBackend.previousYear()
            onNext: calendarBackend.nextYear()
            onHeaderClicked: {
                updateDecadeOverview();
                stack.push(decadeOverview)
            }
            onActivated: {
                calendarBackend.goToMonth(date.monthNumber)
                stack.pop()
            }
        }
    }

    Component {
        id: decadeOverview

        DaysCalendar {
            readonly property int decade: {
                var year = calendarBackend.displayedDate.getFullYear()
                return year - year % 10
            }

            title: decade + " – " + (decade + 9)
            columns: 3
            rows: 4

            dateMatchingPrecision: Calendar.MatchYear

            gridModel: yearModel

            previousLabel: i18nd("libplasma5", "Previous Decade")
            nextLabel: i18nd("libplasma5", "Next Decade")

            onPrevious: calendarBackend.previousDecade()
            onNext: calendarBackend.nextDecade()
            onActivated: {
                calendarBackend.goToYear(date.yearNumber)
                stack.pop()
            }
        }
    }

    Component.onCompleted: {
        root.currentDate = calendarBackend.today
    }
}
