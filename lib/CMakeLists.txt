set(LIB_NAME libpcal)

set(lib_PUBLIC_HEADERS
    pabstructcalendar.h
    pchinesecalendar.h
    pgregoriancalendar.h
)

set(lib_PRIVATE_HEADERS
    picucalendar_p.h
)

set(lib_SOURCES
    pabstructcalendar.cpp
    pchinesecalendar.cpp
    pgregoriancalendar.cpp
    picucalendar_p.cpp
)

add_library (${LIB_NAME} STATIC
    ${lib_PUBLIC_HEADERS}
    ${lib_PRIVATE_HEADERS}
    ${lib_SOURCES}
)

target_include_directories(${LIB_NAME} INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

target_link_libraries(${LIB_NAME} PRIVATE Qt${QT_VERSION_MAJOR}::Widgets ICU::uc ICU::i18n)
