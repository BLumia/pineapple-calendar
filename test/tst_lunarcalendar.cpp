#include <QString>
#include <QtTest>

#include <pchinesecalendar.h>
#include <pgregoriancalendar.h>

class PCalLunarCalendarTest : public QObject
{
    Q_OBJECT

public:
    PCalLunarCalendarTest();

private Q_SLOTS:
    void testCase_DateName();
};

PCalLunarCalendarTest::PCalLunarCalendarTest()
{
    //
}

void PCalLunarCalendarTest::testCase_DateName()
{
    PChineseCalendar ccal;
    PGregorianCalendar gcal;
    gcal.setDate(2020, 12, 24);
    ccal.setTime(gcal.time());

    QCOMPARE(ccal.alternateDayDisplayName(), QStringLiteral("初十")); // is this check okay? better approach?
}

QTEST_APPLESS_MAIN(PCalLunarCalendarTest)

#include "tst_lunarcalendar.moc" 
