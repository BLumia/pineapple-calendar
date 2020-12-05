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
    return (day() == 1) ? monthDisplayName() :  dayDisplayName(); 
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
            result[0] = d % 10 == 0 ? zot[0] : zot[1]; break;
        case 2:
            result[0] = d % 10 == 0 ? a[2] : zot[2]; break;
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
