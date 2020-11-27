The motivation is to solve the issue that we, well, I, cannot watch Chinese Lunar Calendar under KDE. The current goal of this project is, provide some generic code (probably a library) so I can create a plasmoid for Plasma 5 to display Chinese Lunar Calendar, and also provide a simple standalone application which also use the same code for quick testing and maybe some further development.

Although the goal of this project will only provide Simple Chinese Luni-solar calendar support, I still would like to make the code extendable/flexable to be able to implement other calendar system support.

Actually I'm not familiar with the date and time thing, it could be more complex when we also need to combine with different locales, so correct me if anything mentioned here is wrong. I'll also provide the resources I found here when needed.

### Why not using QCalendar?

Right now QCalendar doesn't support Chinese calendar at all...

List of supported calendar system from Qt 5.15.1 at the time of I write this README file are:

"Julian", "Islamic Civil", "Jalali", "Milankovic", "Persian", "Islamic", "islamic-civil", "islamicc", "gregory", "Gregorian"

### Why not writing QCalendar plugin?

Well, there are some issues I've found when I do resources about calendar system and QCalendar support, and here are something I feel very weird about the current QCalendar implementation.

Firstly, writing a QCalendar plugin requires we subclass `QCalendarBackend`, which is a private API, also in their API doc, there is a `QCalendar::YearMonthDay` type which even doesn't have a related documentation.

Secondly, it seems it's not able to handle *leap month(闰月)*, for example, if we have a *leap month 8(闰八月)*, I'm not sure what will happen with the current QCalendar implementation. Assume it will get a 9 for month, then I don't really know if it is a *JiuYue(九月, literally, September)* or a *leap month 8(闰八月)*..

Last but not least, QCalendar seems doesn't care about TimeZone at all, when calling `QCalendar::partsFromDate()`, I'm not sure which timezone it will be treatd with the `QDate`...
