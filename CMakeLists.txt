cmake_minimum_required(VERSION 3.16)

project(ComItem VERSION 1.0 LANGUAGES CXX)

# 设置 CMake 策略
cmake_policy(SET CMP0177 NEW)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 设置QML输出目录
set(QT_QML_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/qml")

find_package(Qt6 6.8 COMPONENTS Quick REQUIRED)

# 设置 Qt 策略
qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

# 定义QML模块路径
set(QT_SDK_DIR "${Qt6_DIR}/../../..")
cmake_path(SET QT_SDK_DIR NORMALIZE ${QT_SDK_DIR})
message("CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")
message("QT_SDK_DIR: ${QT_SDK_DIR}")


# 创建共享库而非静态库，以便其他程序可以动态加载
qt_add_library(ComItem SHARED)

# 添加QML模块
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
    OUTPUT_DIRECTORY "${QT_QML_OUTPUT_DIRECTORY}/ComItem"
    # RESOURCE_PREFIX "/qt/qml"
)

# 设置目标属性
set_target_properties(ComItem PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# 导出符号（Windows下需要）
target_compile_definitions(ComItem
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
    PRIVATE COMITEM_LIBRARY
)

target_link_libraries(ComItem
    PRIVATE Qt6::Quick
)

target_include_directories(ComItem PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# ==================== 安装配置 ====================

# 默认安装到Qt SDK的qml目录
if(NOT DEFINED INSTALL_QML_DIR)
    set(INSTALL_QML_DIR "${QT_SDK_DIR}/qml/ComItem")
endif()

message("INSTALL_QML_DIR: ${INSTALL_QML_DIR}")

# 安装后端库和插件
install(TARGETS ComItem
    LIBRARY DESTINATION "${INSTALL_QML_DIR}"
    RUNTIME DESTINATION "${INSTALL_QML_DIR}"
    ARCHIVE DESTINATION "${INSTALL_QML_DIR}"
)

install(TARGETS ComItemplugin
    LIBRARY DESTINATION "${INSTALL_QML_DIR}"
    RUNTIME DESTINATION "${INSTALL_QML_DIR}"
    ARCHIVE DESTINATION "${INSTALL_QML_DIR}"
)

# 安装qmldir文件（使用生成的版本）
install(FILES
    "${QT_QML_OUTPUT_DIRECTORY}/ComItem/qmldir"
    DESTINATION "${INSTALL_QML_DIR}"
)

# 安装QML类型信息文件（保留原文件名）
install(FILES
    "${QT_QML_OUTPUT_DIRECTORY}/ComItem/ComItem.qmltypes"
    DESTINATION "${INSTALL_QML_DIR}"
    OPTIONAL
)

# 安装QML文件
install(FILES
    ComItemControls.qml
    DESTINATION "${INSTALL_QML_DIR}"
)

# 安装设计器元信息文件
install(FILES
    designer/comitem.metainfo
    DESTINATION "${INSTALL_QML_DIR}/designer"
)

# 安装设计器图标
install(DIRECTORY designer/images/
    DESTINATION "${INSTALL_QML_DIR}/designer/images"
)





# ==================== Example Project ====================
qt_add_executable(ExampleProject example/example.cpp)
qt_add_qml_module(ExampleProject
    URI ExampleProjectApp
    VERSION 1.0
    QML_FILES example/example.qml
)
# 链接后端库（ComItem），插件会在运行时动态加载
target_link_libraries(ExampleProject PRIVATE Qt6::Quick ComItem)
target_compile_definitions(ExampleProject PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

# 设置 Example 项目运行时 QML 导入路径
set_target_properties(ExampleProject PROPERTIES
    VS_DEBUGGER_ENVIRONMENT "QML_IMPORT_PATH=${QT_QML_OUTPUT_DIRECTORY}"
)
