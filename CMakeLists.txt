cmake_minimum_required(VERSION 3.5)

project(pineapple-calendar LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_PLASMOID "Build calendar plasmoid for KDE Plasma 5" OFF)

include(FeatureSummary)

find_package(ECM 1.4.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

find_package(QT NAMES Qt6 Qt5 COMPONENTS Quick Widgets REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Quick Widgets REQUIRED)
find_package(ICU 66.1 COMPONENTS uc i18n REQUIRED)
find_package(KF5 REQUIRED COMPONENTS CoreAddons Declarative I18n)

include(ECMGenerateQmlTypes)

if(BUILD_PLASMOID)
    include(KDEInstallDirs)
    include(KDECMakeSettings)
    include(KDECompilerSettings NO_POLICY_SCOPE)

    find_package(KF5 REQUIRED COMPONENTS Plasma)
    find_package(Qt5 CONFIG REQUIRED COMPONENTS Core)
endif()

add_subdirectory(lib)
add_subdirectory(app)
if(BUILD_PLASMOID)
    add_subdirectory(plasmoid)
endif()

