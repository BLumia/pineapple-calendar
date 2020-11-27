#include "pabstructcalendar.h"

#include <unicode/calendar.h>

using icu::Calendar;

PAbstructCalendar::PAbstructCalendar(QObject *parent) : QObject(parent)
{

}

QString PAbstructCalendar::dayDisplayName() const
{
    return QString::number(day());
}

QString PAbstructCalendar::monthDisplayName() const
{
    return QString::number(month());
}

QString PAbstructCalendar::yearDisplayName() const
{
    return QString::number(year());
}

double PAbstructCalendar::now()
{
    return Calendar::getNow();
}
