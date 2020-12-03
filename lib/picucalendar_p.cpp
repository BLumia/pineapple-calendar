#include "picucalendar_p.h"

PIcuCalendarPrivate::~PIcuCalendarPrivate()
{

}

double PIcuCalendarPrivate::time() const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    UDate time = m_cal->getTime(errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));

    return time;
}

bool PIcuCalendarPrivate::setTime(double time)
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

bool PIcuCalendarPrivate::setDate(int32_t year, int32_t month, int32_t day)
{
    // icu: Month value is 0-based. e.g., 0 for January.
    m_cal->set(year, month - 1, day);

    return true;
}

bool PIcuCalendarPrivate::setTimeZone(const QString &timezoneId)
{
    QScopedPointer<TimeZone> timeZone(TimeZone::createTimeZone(timezoneId.toStdString().c_str()));
    if (*timeZone == TimeZone::getUnknown()) {
        return false;
    }

    m_cal->adoptTimeZone(timeZone.take());
    return true;
}

int32_t PIcuCalendarPrivate::date() const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    int32_t day = m_cal->get(UCAL_DATE, errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));

    return day;
}

int32_t PIcuCalendarPrivate::month() const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    int32_t month = m_cal->get(UCAL_MONTH, errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));

    return month + 1;
}

int32_t PIcuCalendarPrivate::year() const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    int32_t year = m_cal->get(UCAL_YEAR, errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));

    return year;
}

bool PIcuCalendarPrivate::isLeapMonth() const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    int32_t isLaepMonth = m_cal->get(UCAL_IS_LEAP_MONTH, errorCode);
    Q_ASSERT(!U_FAILURE(errorCode));

    return isLaepMonth;
}

// For formatting, see the documentation of SimpleDateFormat:
// https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/classicu_1_1SimpleDateFormat.html#details
QString PIcuCalendarPrivate::formattedDataString(const UnicodeString &str) const
{
    UErrorCode errorCode = U_ZERO_ERROR;
    UnicodeString dateString;
    SimpleDateFormat* formatter = new SimpleDateFormat(str, errorCode);
    formatter->setCalendar(*m_cal);
    formatter->format(m_cal->getTime(errorCode), dateString);

    std::string utf8Str;
    dateString.toUTF8String<std::string>(utf8Str);

    return QString::fromUtf8(utf8Str.c_str());
}
