set(calendarutils_SRCS
    calendarutilsplugin.h
    calendarutilsplugin.cpp
    calendarutils.h
    calendarutils.cpp
    qmldir
)

add_library(calendarutils SHARED ${calendarutils_SRCS})

configure_file(qmldir ${CMAKE_CURRENT_BINARY_DIR} COPYONLY)
if(WIN32)
    set_target_properties(calendarutils PROPERTIES PREFIX "") # get rid of the lib prefix
endif()

target_link_libraries(calendarutils
    Qt5::Core
    Qt5::Quick
    Qt5::Qml
    Qt5::Gui
    libpcal
)

#install(TARGETS calendarplugin DESTINATION ${KDE_INSTALL_QMLDIR}/org/kde/plasma/calendar)
#install(DIRECTORY qml/ DESTINATION ${KDE_INSTALL_QMLDIR}/org/kde/plasma/calendar)
