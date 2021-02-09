#include "pchinesecalendar.h"

#include "picucalendar_p.h"

#include <unicode/calendar.h>
#include <unicode/smpdtfmt.h>

#include <QDebug>

using icu::Calendar;
using icu::Locale;
using icu::SimpleDateFormat;
using icu::TimeZone;
using icu::UnicodeString;

class PChineseCalendarPrivate : public PIcuCalendarPrivate
{
public:
    explicit PChineseCalendarPrivate(PChineseCalendar *q);
    ~PChineseCalendarPrivate();

    QString yearDisplayName() const;
    QString monthDisplayName() const;
    QString dayDisplayName() const;

private:
    PAbstructCalendar *q_ptr;
    Q_DECLARE_PUBLIC(PAbstructCalendar)
};

PChineseCalendarPrivate::PChineseCalendarPrivate(PChineseCalendar *q)
    : q_ptr(q)
{
    Locale locale("en_US", 0, 0, "calendar=chinese");
    UErrorCode errorCode = U_ZERO_ERROR;
    m_cal = Calendar::createInstance(TimeZone::createTimeZone("GMT+8:00"), locale, errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));
}

PChineseCalendarPrivate::~PChineseCalendarPrivate()
{

}

QString PChineseCalendarPrivate::yearDisplayName() const
{
    return formattedDataString("U");
}

QString PChineseCalendarPrivate::monthDisplayName() const
{
    return formattedDataString("MMM");
}

QString PChineseCalendarPrivate::dayDisplayName() const
{
    return formattedDataString("d", true);
}

// --------------- Item Get Border Line --------------- //

PChineseCalendar::PChineseCalendar(QObject *parent)
    : PAbstructCalendar(parent)
    , d_ptr(new PChineseCalendarPrivate(this))
{

}

PChineseCalendar::~PChineseCalendar()
{

}

QString PChineseCalendar::calendarName() const
{
    return QStringLiteral("chinese");
}

QString PChineseCalendar::calendarDisplayName() const
{
    return tr("Chinese calendar - Simple Chinese");
}

double PChineseCalendar::time() const
{
    Q_D(const PChineseCalendar);

    return d->time();
}

bool PChineseCalendar::setTime(const double time)
{
    Q_D(PChineseCalendar);

    return d->setTime(time);
}

bool PChineseCalendar::setDate(int32_t year, int32_t month, int32_t day)
{
    Q_D(PChineseCalendar);

    return d->setDate(year, month, day);
}

bool PChineseCalendar::setTimeZone(const QString timezoneId)
{
    Q_D(PChineseCalendar);

    return d->setTimeZone(timezoneId);
}

QString PChineseCalendar::alternateDayDisplayName() const
{
    return (day() == 1) ? monthDisplayName() : dayDisplayName();
}

QString PChineseCalendar::dayDisplayName() const
{
    Q_D(const PChineseCalendar);

    return d->dayDisplayName();
}

QString PChineseCalendar::monthDisplayName() const
{
    Q_D(const PChineseCalendar);
//    return (isLeapMonth() ? QString("闰%1月") : QString("%1月")).arg(month());
    return d->monthDisplayName();
}

QString PChineseCalendar::yearDisplayName() const
{
    Q_D(const PChineseCalendar);

    return d->yearDisplayName();
}

int PChineseCalendar::day() const
{
    Q_D(const PChineseCalendar);

    return d->date();
}

int PChineseCalendar::month() const
{
    Q_D(const PChineseCalendar);

    return d->month();
}

int PChineseCalendar::year() const
{
    Q_D(const PChineseCalendar);

    return d->year();
}

bool PChineseCalendar::isLeapMonth() const
{
    Q_D(const PChineseCalendar);

    return d->isLeapMonth();
}
