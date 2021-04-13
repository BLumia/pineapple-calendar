/*
    SPDX-FileCopyrightText: 2021 Gary Wang <wzc782970009@gmail.com>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

#pragma once

#include <QQmlExtensionPlugin>

class QQmlEngine;

class CalendarUtilsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri) override;
};

