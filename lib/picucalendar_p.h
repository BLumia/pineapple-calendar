#pragma once

#include <unicode/calendar.h>
#include <unicode/smpdtfmt.h>

#include <QScopedPointer>
#include <QString>

using icu::Calendar;
using icu::Locale;
using icu::SimpleDateFormat;
using icu::TimeZone;
using icu::UnicodeString;

class PIcuCalendarPrivate
{
public:
    virtual ~PIcuCalendarPrivate();

    virtual double time() const;
    virtual bool setTime(double time);
    virtual bool setDate(int32_t year, int32_t month, int32_t day);
    virtual bool setTimeZone(const QString & timezoneId);

    virtual int32_t date() const;
    virtual int32_t month() const;
    virtual int32_t year() const;
    virtual bool isLeapMonth() const;

    QString formattedDataString(const UnicodeString & str) const;

protected:
    Calendar * m_cal = nullptr;
};
