/*
    SPDX-FileCopyrightText: 2020 Gary Wang <wzc782970009@gmail.com>
    SPDX-License-Identifier: LGPL-2.1-or-later
*/

#include "calendar.h"
#include <KLocalizedString>

calendar::calendar(QObject *parent, const QVariantList &args)
    : Plasma::Applet(parent, args),
      m_nativeText(i18n("CSS is Awesome!"))
{
}

calendar::~calendar()
{
}

QString calendar::nativeText() const
{
    return m_nativeText;
}

QString calendar::alternateCalendarDayText(int year, int month, int day)
{
    m_gregorianCal.setDate(year, month, day);
    m_chineseCal.setTime(m_gregorianCal.time());
    return m_chineseCal.alternateDayDisplayName();
}

K_EXPORT_PLASMA_APPLET_WITH_JSON(calendar, calendar, "metadata.json")

#include "calendar.moc"
