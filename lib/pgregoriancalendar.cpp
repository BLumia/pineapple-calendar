#include "pgregoriancalendar.h"

#include "picucalendar_p.h"

#include <unicode/calendar.h>
#include <unicode/smpdtfmt.h>

using icu::Calendar;
using icu::Locale;
using icu::SimpleDateFormat;
using icu::TimeZone;
using icu::UnicodeString;

class PGregorianCalendarPrivate : public PIcuCalendarPrivate
{
public:
    explicit PGregorianCalendarPrivate(PGregorianCalendar *q);
    ~PGregorianCalendarPrivate();

private:
    PAbstructCalendar *q_ptr;
    Q_DECLARE_PUBLIC(PAbstructCalendar)
};

PGregorianCalendarPrivate::PGregorianCalendarPrivate(PGregorianCalendar *q)
    : q_ptr(q)
{
    Locale locale("en_US", 0, 0);
    UErrorCode errorCode = U_ZERO_ERROR;
    m_cal = Calendar::createInstance(TimeZone::createTimeZone("GMT+8:00"), locale, errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));
}

PGregorianCalendarPrivate::~PGregorianCalendarPrivate()
{

}

// --------------- Item Get Border Line --------------- //

PGregorianCalendar::PGregorianCalendar(QObject *parent)
    : PAbstructCalendar(parent)
    , d_ptr(new PGregorianCalendarPrivate(this))
{

}

PGregorianCalendar::~PGregorianCalendar()
{

}

QString PGregorianCalendar::calendarName() const
{
    return QStringLiteral("gregorian");
}

QString PGregorianCalendar::calendarDisplayName() const
{
    return tr("Gregorian calendar");
}

double PGregorianCalendar::time() const
{
    Q_D(const PGregorianCalendar);

    return d->time();
}

bool PGregorianCalendar::setTime(const double time)
{
    Q_D(PGregorianCalendar);

    return d->setTime(time);
}

bool PGregorianCalendar::setDate(int32_t year, int32_t month, int32_t day)
{
    Q_D(PGregorianCalendar);

    return d->setDate(year, month, day);
}

bool PGregorianCalendar::setTimeZone(const QString timezoneId)
{
    Q_D(PGregorianCalendar);

    return d->setTimeZone(timezoneId);
}

int PGregorianCalendar::day() const
{
    Q_D(const PGregorianCalendar);

    return d->date();
}

int PGregorianCalendar::month() const
{
    Q_D(const PGregorianCalendar);

    return d->month();
}

int PGregorianCalendar::year() const
{
    Q_D(const PGregorianCalendar);

    return d->year();
}

bool PGregorianCalendar::isLeapMonth() const
{
    Q_D(const PGregorianCalendar);

    return d->isLeapMonth();
}
