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
    Calendar * chineseCalendar = Calendar::createInstance(TimeZone::createTimeZone("GMT+8:00"), locale, errorCode); // TimeZone::detectHostTimeZone()
    if (U_FAILURE(errorCode)) {
        // An error occurred. Handle it here.
        qDebug("???");
        return 0;
    }
    chineseCalendar->setTime(Calendar::getNow(), errorCode);

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
