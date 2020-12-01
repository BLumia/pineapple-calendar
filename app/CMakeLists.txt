set(EXE_NAME pcal)

set(app_SOURCES
    main.cpp
    mainwindow.cpp
    mainwindow.h
    pabstructcalendar.cpp
    pabstructcalendar.h
    pchinesecalendar.cpp
    pchinesecalendar.h
    pgregoriancalendar.cpp
    pgregoriancalendar.h
    picucalendar_p.h
    picucalendar_p.cpp
    mainwindow.ui
)

add_executable(${EXE_NAME}
    ${app_SOURCES}
)

target_link_libraries(${EXE_NAME} PRIVATE Qt${QT_VERSION_MAJOR}::Widgets ICU::uc ICU::i18n)
