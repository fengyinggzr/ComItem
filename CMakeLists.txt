cmake_minimum_required(VERSION 3.16)

project(ComItem VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_OUTPUT_DIRECTORY  "${CMAKE_BINARY_DIR}/qml/ComItem")

find_package(Qt6 6.8 COMPONENTS Quick REQUIRED)

# # 定义QML模块路径
set(QT_SDK_DIR "${Qt6_DIR}/../../..")
# # set(QT_SDK_DIR "D:/Qt/Qt6.8/6.8.1/msvc2022_64")
cmake_path(SET QT_SDK_DIR NORMALIZE ${QT_SDK_DIR})
message("CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")

qt_add_library(ComItem STATIC)
qt_add_qml_module(ComItem
    URI ComItem
    VERSION 1.0
    QML_FILES 
        ComItemControls.qml
    SOURCES 
        comitem.cpp 
        comitem.h
    DESIGNER_SUPPORTED
    PLUGIN_TARGET ComItemplugin
    OUTPUT_DIRECTORY ${QT_QML_OUTPUT_DIRECTORY}
    RESOURCE_PREFIX "/qt-project.org/imports"
)

set_target_properties(ComItem PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(ComItem
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(ComItem
    PRIVATE Qt6::Quick)

target_include_directories(ComItem PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})



# 安装插件到标准位置
install(TARGETS ComItem ComItemplugin
    LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/qml/ComItem
    RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/qml/ComItem
)

# 安装QML文件和qmldir
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/qml/ComItem/qmldir
    DESTINATION ${CMAKE_INSTALL_PREFIX}/qml/ComItem
)

install(FILES
    ComItemControls.qml
    ComItemControls.qml.metainfo
    DESTINATION ${CMAKE_INSTALL_PREFIX}/qml/ComItem
)

# 安装设计器支持文件
install(DIRECTORY designer/
    DESTINATION ${CMAKE_INSTALL_PREFIX}/qml/ComItem/designer
)





# Example Project
qt_add_executable(ExampleProject example/example.cpp)
qt_add_qml_module(ExampleProject
    URI ExampleProjectApp
    VERSION 1.0
    QML_FILES example/example.qml
)
target_link_libraries(ExampleProject PRIVATE Qt6::Quick ComItemplugin)
target_compile_definitions(ExampleProject PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
