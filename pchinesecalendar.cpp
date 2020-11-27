#include "pchinesecalendar.h"

#include <unicode/calendar.h>
#include <unicode/smpdtfmt.h>

#include <QDebug>

using icu::Calendar;
using icu::Locale;
using icu::SimpleDateFormat;
using icu::TimeZone;
using icu::UnicodeString;

class PChineseCalendarPrivate
{
public:
    explicit PChineseCalendarPrivate(PChineseCalendar *q);
    ~PChineseCalendarPrivate();

    double time() const;
    bool setTime(double time);

    int32_t date() const;
    int32_t month() const;
    int32_t year() const;
    bool isLeapMonth() const;

    QString yearDisplayName() const;

private:
    Calendar * m_cal = nullptr;

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

double PChineseCalendarPrivate::time() const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    UDate time = m_cal->getTime(errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));

    return time;
}

bool PChineseCalendarPrivate::setTime(double time)
{
    UErrorCode errorCode = U_ZERO_ERROR;
    m_cal->setTime(time, errorCode);
    if (U_FAILURE(errorCode)) {
        // An error occurred. Handle it here.
        // TODO.
        return false;
    }

    return true;
}

int32_t PChineseCalendarPrivate::date() const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    int32_t day = m_cal->get(UCAL_DATE, errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));

    return day;
}

int32_t PChineseCalendarPrivate::month() const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    int32_t month = m_cal->get(UCAL_MONTH, errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));

    return month;
}

int32_t PChineseCalendarPrivate::year() const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    int32_t year = m_cal->get(UCAL_YEAR, errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));

    return year;
}

bool PChineseCalendarPrivate::isLeapMonth() const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    int32_t isLaepMonth = m_cal->get(UCAL_IS_LEAP_MONTH, errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));

    return isLaepMonth;
}

QString PChineseCalendarPrivate::yearDisplayName() const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    UnicodeString s("U"), dateString;
    SimpleDateFormat* formatter = new SimpleDateFormat(s, errorCode);
    formatter->setCalendar(*m_cal);
    formatter->format(m_cal->getTime(errorCode), dateString);
    return QString::fromUtf16(dateString.getBuffer());
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

QString PChineseCalendar::dayDisplayName() const
{
    auto dayNameByDate = [](int d) -> std::wstring {
        const std::wstring zot=L"初十廿三";
        const std::wstring a=L"十一二三四五六七八九";
        std::wstring result=L"这啥";
        switch (d / 10) {
        case 0:
            result[0] = zot[0]; break;
        case 1:
            result[0] = zot[1]; break;
        case 2:
            result[0] = zot[2]; break;
        default:
            result[0] = zot[3];
        }
        result[1] = a[d % 10];

        return result;
    };

    return QString::fromStdWString(dayNameByDate(day()));
}

QString PChineseCalendar::monthDisplayName() const
{
    return (isLeapMonth() ? QString("闰%1月") : QString("%1月")).arg(month());
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
