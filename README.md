# Pineapple Calendar

*Note: since Plasma 5.26, the Digital Clock plasmoid comes from KDE now has built-in support for alternate calendar!*

[Install Guide | 安装指南](https://github.com/BLumia/pineapple-calendar/wiki/%E5%AE%89%E8%A3%85%E6%8C%87%E5%8D%97)

The motivation is to solve the issue that we, well, I, was not able to watch Chinese Lunar Calendar under KDE. The current goal of this project is, provide some generic code (probably a library) so I can create a plasmoid for Plasma 5 to display Chinese Lunar Calendar, and also provide a simple standalone application which also use the same code for quick testing and maybe some further development.

Although the goal of this project will only provide Simple Chinese Luni-solar calendar support, I still would like to make the code extendable/flexable to be able to implement other calendar system support.

Actually I'm not familiar with the date and time thing, it could be more complex when we also need to deal with different locales, so correct me if anything mentioned here is wrong. I'll also provide the resources I found here when needed.

## Intended Outcome

### Current Goal

 - [x] A Plasmoid for KDE Plasma 5, which can...
   - [x] display a Gregorian Calendar as main calendar.
   - [x] display a Simple Chinese Lunar (luni-solar) calendar as alternate calendar.
 - [x] See the possibility if we can get this feature into KDE
   - [See this page which will track the state of the force to make the feature into KDE](https://github.com/BLumia/pineapple-calendar/wiki/Make-the-feature-into-KDE)

### Non-goal, but may consider

 - Support calendar events.
   - Support *Solar Terms(节气)* via calendar events.
   - Support ics.

## Building

Current state we already got a usable applet for the most recent KDE Plasma Environment, see the instruction below about how to try it out.

By default it will only build the standalone application (for simple testing). The plasmoid won't build unless you enable the `BUILD_PLASMOID` CMake option. Also please notice this applet only contains a hard-coded Chinese lunar calendar as alternate calendar.

### Build and test the plasmoid

Ensure you build with `-DBUILD_PLASMOID=ON` option, do `sudo make install` once your compile completed.

Once it's installed, you can right click the digital clock applet and replace with the "Date and Calendar" applet. Or if you just would like to see what it's like, you can use `plasmoidviewer`:

``` shell
$ plasmoidviewer -a net.blumia.pineapple.calendar -l topedge -f horizontal
```

*Note: I'm not sure how to get the c++ native plugin loaded if you use custom DESTDIR for your installation, don't change install dir if you don't know either, and please let me know if you know*

## Other stuff

Files under `/plasmoid/package/contents/ui/calendar/` are forked from `plasma-framework` with path `/src/declarativeimports/calendar/qml/` and commit hash `532817c00455ef7ddb400529b9c102f142db508b`.

All `.cpp` and `.h` files which under `/app/declarativeimports/net/blumia/pineapple/calendar/` and `.qml` files under `/app/calendar/` are forked from `plasma-framework` with path `/src/declarativeimports/calendar/` and commit hash `532817c00455ef7ddb400529b9c102f142db508b`, except `CalendarView.qml` is forked from `plasma-workspace` with tag `5.21`.

If you have any suggestion about my implementation, or have any better idea about pushing alternate calendar support into KDE, please feel free to open up a new issue, or comment on the [feature request](https://bugs.kde.org/show_bug.cgi?id=429892) in the KDE bug tracker or [the Google Document page about my thought](https://docs.google.com/document/d/1iwEwwK9w34ZKOegb8xcecO4u2Pjgv2e7ifXMFKox62Q/edit?usp=sharing), or write to [**plasma-devel** mailing list](https://mail.kde.org/mailman/listinfo/plasma-devel)!

### License?

TBD, will be released under an OSI approved DFSG-compatible license.

For the plasma applet which provided in this repo, it's licensed under the license of [LGPL-2.1-or-later](https://spdx.org/licenses/LGPL-2.1-or-later.html).
