/*
    SPDX-FileCopyrightText: 2020 Gary Wang <wzc782970009@gmail.com>
    SPDX-License-Identifier: LGPL-2.1-or-later
*/

#ifndef CALENDAR_H
#define CALENDAR_H


#include <Plasma/Applet>

#include "../app/pchinesecalendar.h"
#include "../app/pgregoriancalendar.h"

class calendar : public Plasma::Applet
{
    Q_OBJECT
    Q_PROPERTY(QString nativeText READ nativeText CONSTANT)

public:
    calendar( QObject *parent, const QVariantList &args );
    ~calendar();

    QString nativeText() const;

    Q_INVOKABLE QString alternateCalendarDayText(int year, int month, int day);

private:
    QString m_nativeText;

    PChineseCalendar m_chineseCal;
    PGregorianCalendar m_gregorianCal;
};

#endif
