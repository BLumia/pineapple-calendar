set(BIN_NAME calendarutils)

set(calendarutils_SRCS
    calendarutilsplugin.h
    calendarutilsplugin.cpp
    calendarutils.h
    calendarutils.cpp
    qmldir
)

add_library(${BIN_NAME} SHARED ${calendarutils_SRCS})

configure_file(qmldir ${CMAKE_CURRENT_BINARY_DIR} COPYONLY)
if(WIN32)
    set_target_properties(${BIN_NAME} PROPERTIES PREFIX "") # get rid of the lib prefix
endif()

target_link_libraries(${BIN_NAME}
    Qt5::Core
    Qt5::Quick
    Qt5::Qml
    libpcal
)

install(TARGETS ${BIN_NAME} DESTINATION ${KDE_INSTALL_QMLDIR}/net/blumia/calendar)
install (
    FILES ${CMAKE_CURRENT_BINARY_DIR}/qmldir
    DESTINATION ${KDE_INSTALL_QMLDIR}/net/blumia/calendar
)
