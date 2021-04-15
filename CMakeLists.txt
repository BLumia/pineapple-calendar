cmake_minimum_required(VERSION 3.5)

project(pineapple-calendar LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_STANDALONE_APP "Build the standalone application" OFF)
option(BUILD_DECLARATIVE_EXTENSION "Build the Calendar Utils QML extension" ON)
option(BUILD_PLASMOID "Build calendar plasmoid applet for KDE Plasma 5" OFF)

include(FeatureSummary)
include(CTest)

if (BUILD_STANDALONE_APP OR BUILD_DECLARATIVE_EXTENSION OR BUILD_PLASMOID)
    find_package(ECM 1.4.0 REQUIRED NO_MODULE)
    set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
endif()

# anyway libpcal will always be built.
find_package(QT NAMES Qt5 COMPONENTS Widgets REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Widgets Test REQUIRED)
find_package(ICU 66.1 COMPONENTS uc i18n REQUIRED)

if (BUILD_STANDALONE_APP)
    find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Quick Qml Test REQUIRED)
    find_package(KF5 REQUIRED COMPONENTS CoreAddons Declarative I18n)

    include(ECMGenerateQmlTypes) # probably useless..
endif()

if (BUILD_TESTING)
    find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Test REQUIRED)
endif()

if (BUILD_DECLARATIVE_EXTENSION)
    find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Quick Qml REQUIRED)
endif()

if(BUILD_PLASMOID)
    include(KDEInstallDirs)

    find_package(KF5 REQUIRED COMPONENTS Plasma)
endif()

# Then let's add the sub directories...

add_subdirectory(lib)

if (BUILD_STANDALONE_APP)
    add_subdirectory(app)
endif()

if (BUILD_TESTING)
    add_subdirectory(test)
endif()

if (BUILD_STANDALONE_APP OR BUILD_DECLARATIVE_EXTENSION OR BUILD_PLASMOID)
    add_subdirectory(declarativeimports)
endif ()

if(BUILD_PLASMOID)
    add_subdirectory(plasmoid)
endif()

