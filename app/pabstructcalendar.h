#ifndef PCALENDARINTERFACE_H
#define PCALENDARINTERFACE_H

#include <QObject>

// mainly for alternate calendar.
class PAbstructCalendar : public QObject
{
    Q_OBJECT
public:
    explicit PAbstructCalendar(QObject *parent = nullptr);

    // the name used by CLDR is recommended here.
    virtual QString calendarName() const = 0;
    virtual QString calendarDisplayName() const = 0;
    // Non-local UTC (GMT) time in milliseconds.
    virtual double time() const = 0;
    // Sets this Calendar's current time with the given \time.
    // The \l time specified should be in non-local UTC (GMT) time in milliseconds.
    virtual bool setTime(const double time) = 0;
    // Roll the calendar to the gaven year, month and day.
    // The year, month and day IS in THIS calendar system, NOT Proleptic Gregorian calendar
    virtual bool setDate(int32_t year, int32_t month, int32_t day) = 0;
    // \l timezoneId is the IANA ID for a TimeZone, such as
    // "America/Los_Angeles", or a custom ID such as "GMT-8:00"
    // List of timezone IDs: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
    virtual bool setTimeZone(const QString timezoneId);
    virtual QString dayDisplayName() const;
    virtual QString monthDisplayName() const;
    virtual QString yearDisplayName() const;
    virtual int day() const = 0;
    virtual int month() const = 0;
    virtual int year() const = 0;
    virtual bool isLeapMonth() const = 0;

    // Returns the current UTC (GMT) time measured in milliseconds
    // since 0:00:00 on 1970-01-01 (derived from the system time).
    static double now();
};

#endif // PCALENDARINTERFACE_H
