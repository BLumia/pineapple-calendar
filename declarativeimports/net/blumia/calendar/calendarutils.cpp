/*
    SPDX-FileCopyrightText: 2021 Gary Wang <wzc782970009@gmail.com>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

#include "calendarutils.h"

CalendarUtils::CalendarUtils(QObject *parent) : QObject(parent)
{

}

CalendarUtils::~CalendarUtils()
{

}

QString CalendarUtils::alternateCalendarDayText(int year, int month, int day)
{
    m_gregorianCal.setDate(year, month, day);
    m_chineseCal.setTime(m_gregorianCal.time());
    return m_chineseCal.alternateDayDisplayName();
}
