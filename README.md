# Pineapple Calendar

The motivation is to solve the issue that we, well, I, am not able to watch Chinese Lunar Calendar under KDE. The current goal of this project is, provide some generic code (probably a library) so I can create a plasmoid for Plasma 5 to display Chinese Lunar Calendar, and also provide a simple standalone application which also use the same code for quick testing and maybe some further development.

Although the goal of this project will only provide Simple Chinese Luni-solar calendar support, I still would like to make the code extendable/flexable to be able to implement other calendar system support.

Actually I'm not familiar with the date and time thing, it could be more complex when we also need to deal with different locales, so correct me if anything mentioned here is wrong. I'll also provide the resources I found here when needed.

## Intended Outcome

### Current Goal

 - A Plasmoid for KDE Plasma 5, which can...
   - display a Gregorian Calendar as main calendar.
   - display a Simple Chinese Lunar (luni-solar) calendar as alternate calendar.
 - A standalone Qt calendar application, which...
   - use Gregorian Calendar as main calendar, can set alternate calendar which loaded via its plugin system.
   - comes with a Simple Chinese Lunar calendar plugin.
   - share the same code with the Plasmoid one as much as possible.

### Non-goal, but may consider

 - Support calendar events.
   - Support *Solar Terms(节气)* via calendar events.
   - Support ics.

## Building

Current state is totally unusable but in case you are interested..

By default it will only build the standalone application. The plasmoid won't build unless you enable the `BUILD_PLASMOID` CMake option.

### Build and test the plasmoid

Ensure you build with `-DBUILD_PLASMOID=ON` option, do `sudo make install` once your compile completed.

``` shell
$ plasmoidviewer -a net.blumia.pineapple.calendar -l topedge -f horizontal
```

*Note: I'm not sure how to get the c++ native plugin loaded if you use custom DESTDIR for your installation, don't change install dir if you don't know either, and please let me know if you know*

## Questions

### Why not using QCalendar?

Right now QCalendar doesn't support Chinese calendar at all...

List of supported calendar system from Qt 5.15.1 at the time of I write this README file are:

"Julian", "Islamic Civil", "Jalali", "Milankovic", "Persian", "Islamic", "islamic-civil", "islamicc", "gregory", "Gregorian"

### Why not writ a QCalendar plugin?

Well, there are some issues I've found when I do resources about calendar system and QCalendar support, and here are something I feel very weird about the current QCalendar implementation.

Firstly, writing a QCalendar plugin requires we subclass `QCalendarBackend`, which is a private API, also in their API doc, there is a `QCalendar::YearMonthDay` type which even doesn't have a related documentation.

Secondly, it seems it's not able to handle *leap month(闰月)*, for example, if we have a *leap month 8(闰八月)*, I'm not sure what will happen with the current QCalendar implementation. Assume it will get a 9 for month, then I don't really know if it is a *JiuYue(九月, literally, September)* or a *leap month 8(闰八月)*..

*remark: there is a `QCalendar::monthName()` which may partially resolve this issue, so yeah we can get a proper display name, but still doesn't know if the month is a leap month*

Last but not least, QCalendar seems doesn't care about TimeZone at all, when calling `QCalendar::partsFromDate()`, I'm not sure which timezone it will be treatd with the `QDate`...

### Why an interface and an implementation? Why not just an implementation?

As said above, I still would like to make the code flexable enough to be able to implement other calendar system support. The standalone application will use a Gregorian Calendar as the main calendar and will be able to set alternate calendar from the application settings. The alternate calendars will be provided via its plugin system so maybe someone is able to re-use the application to fit their own needs.

Also, while doing resources, I found we may [get the wrong date when using icu (link to Chinese website)](https://www.v2ex.com/t/505601), although icu4c is what I still planned to use for this project, it can be easy to replace my implementation with other implementation which doesn't rely on icu if we provide an interface and a plugin system..

### Why not contribute to existed projects?

Well, we can't say I'm not going to do contribute to existed projects. The main goal sounds pretty simple but there may be a lots of things should get considered. Since I'm not familiar with a lots of concepts related to calendar system support, I think it can be better to submit patches to existed project when I know how to implement this thing in a clean way.

Also, we should know if existed project can accept such feature request (since they doesn't support it). When I think I can submit a patch, I'll submit a feature request first to ensure they're willing to accept such feature.

### ~~Why not create a fork of existed project?~~

~~For the plasmoid, originally I planned to fork the KDE plasma official calendar plugin but found out it seems not very easy to splite it out from `plasma-workspace` to a standalone plasmoid plugin, and seems it have a decent (or at least not as bad as what I image) interface, so I can write a simple plasmoid which extend the plasma calendar QML widget to fit my own need.~~

*edit: files under `/plasmoid/package/contents/ui/calendar/` forked from `plasma-workspace` with path `/src/declarativeimports/calendar/qml/` and commit hash `431d4cc0d4507ff8dc6b64fc039817635b600e65`*

For the standalone application, since it's mainly for testing (at least at this moment), write from scratch will be better.

### License?

TBD, will be released under an OSI approved DFSG-compatible license.
