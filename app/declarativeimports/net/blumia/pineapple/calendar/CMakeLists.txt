set(calendar_SRCS
    calendarplugin.cpp
    #incidencemodifier.cpp
    calendar.cpp
    calendardata.cpp
    #calendardayhelper.cpp
    #calendarroleproxymodel.cpp
    #datetimerangefiltermodel.cpp
    daysmodel.cpp
    eventdatadecorator.cpp
    eventpluginsmanager.cpp
)

add_library(calendarplugin SHARED ${calendar_SRCS})

configure_file(qmldir ${CMAKE_CURRENT_BINARY_DIR} COPYONLY)
if(WIN32)
    set_target_properties(calendarplugin PROPERTIES PREFIX "") # get rid of the lib prefix
endif()

target_link_libraries(calendarplugin
    Qt5::Core
    Qt5::Quick
    Qt5::Qml
    Qt5::Gui
    KF5::I18n
    KF5::CalendarEvents
    KF5::CoreAddons
)

#install(TARGETS calendarplugin DESTINATION ${KDE_INSTALL_QMLDIR}/org/kde/plasma/calendar)
#install(DIRECTORY qml/ DESTINATION ${KDE_INSTALL_QMLDIR}/org/kde/plasma/calendar)
