set(EXE_NAME pcal)

set(app_SOURCES
    main.cpp
    mainwindow.cpp
    mainwindow.h
    mainwindow.ui
)

add_executable(${EXE_NAME}
    ${app_SOURCES}
)

target_link_libraries(${EXE_NAME} PRIVATE Qt${QT_VERSION_MAJOR}::Widgets ICU::uc ICU::i18n libpcal)
