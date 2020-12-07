set(EXE_NAME pcal)

set(app_SOURCES
    main.cpp
    qml.qrc
)

add_executable(${EXE_NAME}
    ${app_SOURCES}
)

target_link_libraries(${EXE_NAME} PRIVATE Qt${QT_VERSION_MAJOR}::Widgets Qt${QT_VERSION_MAJOR}::Quick ICU::uc ICU::i18n libpcal)

add_subdirectory(declarativeimports/net/blumia/pineapple/calendar)
