/*
    SPDX-FileCopyrightText: 2021 Gary Wang <wzc782970009@gmail.com>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

#include "calendarutilsplugin.h"
#include "calendarutils.h"

#include <QQmlEngine>

void CalendarUtilsPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QByteArray("net.blumia.calendar"));

    qmlRegisterSingletonType<CalendarUtils>(uri, 0, 1, "CalendarUtils",
    [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        return new CalendarUtils();
    });
}
