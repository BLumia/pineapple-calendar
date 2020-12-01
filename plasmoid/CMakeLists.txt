add_definitions(-DTRANSLATION_DOMAIN=\"plasma_applet_net.blumia.pineapple.calendar\")

set(calendar_SRCS
    calendar.cpp

    ../app/pabstructcalendar.cpp
    ../app/pabstructcalendar.h
    ../app/pchinesecalendar.cpp
    ../app/pchinesecalendar.h
    ../app/pgregoriancalendar.cpp
    ../app/pgregoriancalendar.h
    ../app/picucalendar_p.h
    ../app/picucalendar_p.cpp
)

add_library(plasma_applet_calendar MODULE ${calendar_SRCS})

kcoreaddons_desktop_to_json(plasma_applet_calendar package/metadata.desktop SERVICE_TYPES plasma-applet.desktop)

target_link_libraries(plasma_applet_calendar
                      Qt5::Gui
                      KF5::Plasma
                      KF5::I18n
                      
                      ICU::uc ICU::i18n)


install(TARGETS plasma_applet_calendar DESTINATION ${KDE_INSTALL_PLUGINDIR}/plasma/applets)

plasma_install_package(package net.blumia.pineapple.calendar)
