#include "mainwindow.h"

#include <QApplication>
#include <QCalendar>
#include <QDebug>

#include <unicode/calendar.h>
#include <unicode/timezone.h>
#include <unicode/locid.h>

#include <unicode/smpdtfmt.h>

#include <iostream>
#include <unicode/unistr.h>

using icu::Calendar;
using icu::TimeZone;
using icu::Locale;
using icu::SimpleDateFormat;
using icu::UnicodeString;

int main(int argc, char *argv[])
{
    Locale locale("en_US", 0, 0, "calendar=chinese");
    UErrorCode errorCode = U_ZERO_ERROR;
    Calendar * gregorianCalendar = Calendar::createInstance(TimeZone::createTimeZone("GMT+8:00"), errorCode); // TimeZone::detectHostTimeZone()
    if (U_FAILURE(errorCode)) {
        // An error occurred. Handle it here.
        qDebug("???");
        return 0;
    }
    Calendar * chineseCalendar = Calendar::createInstance(TimeZone::createTimeZone("GMT+8:00"), locale, errorCode);
    if (U_FAILURE(errorCode)) {
        // An error occurred. Handle it here.
        qDebug("???");
        return 0;
    }
    gregorianCalendar->set(2020, 10, 26); // Calendar::getNow()
    chineseCalendar->setTime(gregorianCalendar->getTime(errorCode), errorCode);

    qDebug() << gregorianCalendar->getType() << chineseCalendar->getType();
    qDebug() << chineseCalendar->get(UCAL_YEAR, errorCode);
    qDebug() << ((chineseCalendar->get(UCAL_IS_LEAP_MONTH, errorCode) == 0) ? "" : "闰") << chineseCalendar->get(UCAL_MONTH, errorCode) + 1 << "月";
    qDebug() << chineseCalendar->get(UCAL_DATE, errorCode) << "日";
    qDebug() << QCalendar::availableCalendars();

    UnicodeString s("r yyyy.MM.dd d dd G U MMM MMMM eee 'at' hh:mm:ss a zzz"), dateString;
    SimpleDateFormat* formatter = new SimpleDateFormat(s, errorCode);
    formatter->setCalendar(*chineseCalendar);
//    FieldPosition fp(FieldPosition::DONT_CARE);
    formatter->format(chineseCalendar->getTime(errorCode), dateString);
    qDebug() << QString::fromUtf16(dateString.getBuffer());

    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    return a.exec();
}
