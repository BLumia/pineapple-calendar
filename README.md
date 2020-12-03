# Pineapple Calendar

The motivation is to solve the issue that we, well, I, am not able to watch Chinese Lunar Calendar under KDE. The current goal of this project is, provide some generic code (probably a library) so I can create a plasmoid for Plasma 5 to display Chinese Lunar Calendar, and also provide a simple standalone application which also use the same code for quick testing and maybe some further development.

Although the goal of this project will only provide Simple Chinese Luni-solar calendar support, I still would like to make the code extendable/flexable to be able to implement other calendar system support.

Actually I'm not familiar with the date and time thing, it could be more complex when we also need to deal with different locales, so correct me if anything mentioned here is wrong. I'll also provide the resources I found here when needed.

## Intended Outcome

### Current Goal

 - [x] A Plasmoid for KDE Plasma 5, which can...
   - [x] display a Gregorian Calendar as main calendar.
   - [x] display a Simple Chinese Lunar (luni-solar) calendar as alternate calendar.
 - [ ] See the possibility if we can get this feature into KDE
   - [Feature request in KDE bugzilla](https://bugs.kde.org/show_bug.cgi?id=429892)
   - [Some thought about the correct way to implement this feature](https://docs.google.com/document/d/1iwEwwK9w34ZKOegb8xcecO4u2Pjgv2e7ifXMFKox62Q/edit?usp=sharing)
   - Please let me know if you have any suggestion or would like to offer any help!
 - [ ] A standalone Qt calendar application, which...
   - [ ] use Gregorian Calendar as main calendar, can set alternate calendar which loaded via its plugin system.
   - [ ] comes with a Simple Chinese Lunar calendar plugin.
   - [ ] share the same code with the Plasmoid one as much as possible.

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

Files under `/plasmoid/package/contents/ui/calendar/` forked from `plasma-framework` with path `/src/declarativeimports/calendar/qml/` and commit hash `431d4cc0d4507ff8dc6b64fc039817635b600e65`

If you have any suggestion about my implementation, or have any better idea about pushing alternate calendar support into KDE, please feel free to open up a new issue, or comment on the [feature request](https://bugs.kde.org/show_bug.cgi?id=429892) in the KDE bug tracker or [the Google Document page about my thought](https://docs.google.com/document/d/1iwEwwK9w34ZKOegb8xcecO4u2Pjgv2e7ifXMFKox62Q/edit?usp=sharing), or write to [**plasma-devel** mailing list](https://mail.kde.org/mailman/listinfo/plasma-devel)!

### License?

TBD, will be released under an OSI approved DFSG-compatible license.
