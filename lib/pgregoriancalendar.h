#ifndef PGREGORIANCALENDAR_H
#define PGREGORIANCALENDAR_H

#include "pabstructcalendar.h"

class PGregorianCalendarPrivate;
class PGregorianCalendar : public PAbstructCalendar
{
public:
    PGregorianCalendar(QObject *parent = nullptr);
    ~PGregorianCalendar();

    // PAbstructCalendar interface
public:
    QString calendarName() const override;
    QString calendarDisplayName() const override;
    double time() const override;
    bool setTime(const double time) override;
    bool setDate(int32_t year, int32_t month, int32_t day) override;
    bool setTimeZone(const QString timezoneId) override;
    int day() const override;
    int month() const override;
    int year() const override;
    bool isLeapMonth() const override;

private:
    QScopedPointer<PGregorianCalendarPrivate> d_ptr;
    Q_DECLARE_PRIVATE(PGregorianCalendar)
};

#endif // PGREGORIANCALENDAR_H
