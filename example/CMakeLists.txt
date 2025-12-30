cmake_minimum_required(VERSION 3.16)

project(ComItemExample VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 判断是否作为子项目构建
if(NOT TARGET Qt6::Quick)
    find_package(Qt6 6.8 COMPONENTS Quick REQUIRED)
endif()

# 设置 Qt 策略
qt_policy(SET QTP0001 NEW)

# 设置 QML 导入路径
# 作为子项目时使用父项目的输出目录，独立构建时使用相对路径
if(DEFINED QT_QML_OUTPUT_DIRECTORY)
    set(QML_IMPORT_PATH "${QT_QML_OUTPUT_DIRECTORY}" CACHE STRING "QML Import Path" FORCE)
else()
    set(QML_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../build/qml" CACHE STRING "QML Import Path")
endif()

qt_add_executable(ComItemExample
    main.cpp
)

qt_add_qml_module(ComItemExample
    URI ComItemExample
    VERSION 1.0
    QML_FILES
        Main.qml
)

# 链接 Qt6::Quick，如果 ComItem 目标存在则也链接它
target_link_libraries(ComItemExample
    PRIVATE Qt6::Quick
)

# 如果作为子项目构建，添加对 ComItem 的依赖
if(TARGET ComItem)
    add_dependencies(ComItemExample ComItem ComItemplugin)
endif()

# 设置目标属性
set_target_properties(ComItemExample PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.comitemexample
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# 设置运行时 QML 导入路径
target_compile_definitions(ComItemExample
    PRIVATE QML_IMPORT_PATH="${QML_IMPORT_PATH}"
)
