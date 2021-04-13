/*
    SPDX-FileCopyrightText: 2021 Gary Wang <wzc782970009@gmail.com>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

#pragma once

#include <QObject>

#include "pchinesecalendar.h"
#include "pgregoriancalendar.h"

class CalendarUtils : public QObject
{
    Q_OBJECT

public:
    CalendarUtils(QObject *parent = nullptr);
    ~CalendarUtils();

    Q_INVOKABLE QString alternateCalendarDayText(int year, int month, int day);

private:
    PChineseCalendar m_chineseCal;
    PGregorianCalendar m_gregorianCal;
};

