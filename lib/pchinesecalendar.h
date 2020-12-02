#ifndef PCHINESECALENDAR_H
#define PCHINESECALENDAR_H

#include "pabstructcalendar.h"

class PChineseCalendarPrivate;
class PChineseCalendar : public PAbstructCalendar
{
    Q_OBJECT
public:
    PChineseCalendar(QObject *parent = nullptr);
    ~PChineseCalendar();

    // PAbstructCalendar interface
public:
    QString calendarName() const override;
    QString calendarDisplayName() const override;
    double time() const override;
    bool setTime(const double time) override;
    bool setDate(int32_t year, int32_t month, int32_t day) override;
    bool setTimeZone(const QString timezoneId) override;
    QString alternateDayDisplayName() const override;
    QString dayDisplayName() const override;
    QString monthDisplayName() const override;
    QString yearDisplayName() const override;
    int day() const override;
    int month() const override;
    int year() const override;
    bool isLeapMonth() const override;

private:
    QScopedPointer<PChineseCalendarPrivate> d_ptr;
    Q_DECLARE_PRIVATE(PChineseCalendar)
};

#endif // PCHINESECALENDAR_H
