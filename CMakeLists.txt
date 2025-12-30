cmake_minimum_required(VERSION 3.16)

project(ComItem VERSION 1.0 LANGUAGES CXX)

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

# ==================== 自动扫描文件 ====================
# 扫描 cpp 目录下的所有 .cpp 和 .h 文件
file(GLOB CPP_SOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "cpp/*.cpp")
file(GLOB CPP_HEADERS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "cpp/*.h")

# 扫描 qml 目录下的所有 .qml 文件
file(GLOB QML_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "qml/*.qml")

# 输出扫描到的文件（调试用）
message("Found C++ sources: ${CPP_SOURCES}")
message("Found C++ headers: ${CPP_HEADERS}")
message("Found QML files: ${QML_FILES}")

# 创建共享库而非静态库，以便其他程序可以动态加载
qt_add_library(ComItem SHARED)

# 添加QML模块
qt_add_qml_module(ComItem
    URI ComItem
    VERSION 1.0
    QML_FILES ${QML_FILES}
    SOURCES ${CPP_SOURCES} ${CPP_HEADERS}
    DESIGNER_SUPPORTED
    PLUGIN_TARGET ComItemplugin
    OUTPUT_DIRECTORY "${QT_QML_OUTPUT_DIRECTORY}/ComItem"
)

# 设置目标属性
set_target_properties(ComItem PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    # Debug 版本添加 d 后缀
    DEBUG_POSTFIX "d"
)

# 设置插件的 Debug 后缀
set_target_properties(ComItemplugin PROPERTIES
    DEBUG_POSTFIX "d"
)

# 导出符号（Windows下需要）
target_compile_definitions(ComItem
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
    PRIVATE COMITEM_LIBRARY
)

target_link_libraries(ComItem
    PRIVATE Qt6::Quick
)

# 添加头文件搜索路径，包括 cpp 子目录
target_include_directories(ComItem 
    PUBLIC 
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/cpp
)

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

# 安装qmldir文件（使用自定义版本，不含 prefer 指令）
install(FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/qmldir"
    DESTINATION "${INSTALL_QML_DIR}"
)

# 安装QML类型信息文件
install(FILES
    "${QT_QML_OUTPUT_DIRECTORY}/ComItem/ComItem.qmltypes"
    DESTINATION "${INSTALL_QML_DIR}"
    OPTIONAL
)

# 安装QML文件（使用扫描到的文件列表）
install(FILES ${QML_FILES}
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

# ==================== CMake 配置文件（供其他项目 find_package 使用）====================
include(CMakePackageConfigHelpers)

# 配置文件安装目录
set(INSTALL_CMAKE_DIR "${QT_SDK_DIR}/lib/cmake/ComItem")
set(PACKAGE_INSTALL_QML_DIR "${INSTALL_QML_DIR}")

# 生成配置文件
configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/ComItemConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/ComItemConfig.cmake"
    INSTALL_DESTINATION "${INSTALL_CMAKE_DIR}"
    PATH_VARS PACKAGE_INSTALL_QML_DIR
)

# 生成版本文件
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/ComItemConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

# 安装 CMake 配置文件
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/ComItemConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/ComItemConfigVersion.cmake"
    DESTINATION "${INSTALL_CMAKE_DIR}"
)

# ==================== 构建后自动复制到 Qt qml 目录 ====================
# 设置输出目录，确保所有配置的输出都在同一位置
set_target_properties(ComItem PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
)
set_target_properties(ComItemplugin PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
)

# 对于多配置生成器（如 Visual Studio），设置每个配置的输出目录
foreach(CONFIG_TYPE ${CMAKE_CONFIGURATION_TYPES})
    string(TOUPPER ${CONFIG_TYPE} CONFIG_TYPE_UPPER)
    set_target_properties(ComItem PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY_${CONFIG_TYPE_UPPER} "${CMAKE_BINARY_DIR}/bin"
        LIBRARY_OUTPUT_DIRECTORY_${CONFIG_TYPE_UPPER} "${CMAKE_BINARY_DIR}/bin"
        ARCHIVE_OUTPUT_DIRECTORY_${CONFIG_TYPE_UPPER} "${CMAKE_BINARY_DIR}/lib"
    )
    set_target_properties(ComItemplugin PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY_${CONFIG_TYPE_UPPER} "${CMAKE_BINARY_DIR}/bin"
        LIBRARY_OUTPUT_DIRECTORY_${CONFIG_TYPE_UPPER} "${CMAKE_BINARY_DIR}/bin"
        ARCHIVE_OUTPUT_DIRECTORY_${CONFIG_TYPE_UPPER} "${CMAKE_BINARY_DIR}/lib"
    )
endforeach()

# ComItem 库构建后复制
add_custom_command(TARGET ComItem POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory "${INSTALL_QML_DIR}"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${INSTALL_QML_DIR}/designer/images"
    # 复制动态库 (Debug: ComItemd.dll, Release: ComItem.dll)
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "$<TARGET_FILE:ComItem>"
        "${INSTALL_QML_DIR}/"
    # 复制导入库 (Debug: ComItemd.lib, Release: ComItem.lib)
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "$<TARGET_LINKER_FILE:ComItem>"
        "${INSTALL_QML_DIR}/"
    # 复制动态库到 Qt bin 目录（供设计器加载插件时找到依赖）
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "$<TARGET_FILE:ComItem>"
        "${QT_SDK_DIR}/bin/"
    COMMENT "Copying ComItem library to Qt qml directory..."
)

# ComItemplugin 构建后复制
add_custom_command(TARGET ComItemplugin POST_BUILD
    # 复制插件动态库
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "$<TARGET_FILE:ComItemplugin>"
        "${INSTALL_QML_DIR}/"
    # 复制插件的导入库 (.lib)
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_BINARY_DIR}/lib/$<IF:$<CONFIG:Debug>,ComItemplugind.lib,ComItemplugin.lib>"
        "${INSTALL_QML_DIR}/"
    # 复制自定义 qmldir
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_CURRENT_SOURCE_DIR}/qmldir"
        "${INSTALL_QML_DIR}/"
    # 复制 qmltypes
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${QT_QML_OUTPUT_DIRECTORY}/ComItem/ComItem.qmltypes"
        "${INSTALL_QML_DIR}/"
    # 复制 qml 目录下所有 QML 文件
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_CURRENT_SOURCE_DIR}/qml"
        "${INSTALL_QML_DIR}/"
    # 复制设计器目录
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_CURRENT_SOURCE_DIR}/designer"
        "${INSTALL_QML_DIR}/designer"
    # 复制 cpp 目录下所有头文件（使用循环复制 .h 文件）
    COMMAND ${CMAKE_COMMAND} -P "${CMAKE_CURRENT_SOURCE_DIR}/cmake/copy_headers.cmake"
        "${CMAKE_CURRENT_SOURCE_DIR}/cpp" "${INSTALL_QML_DIR}"
    # 复制 CMake 配置文件
    COMMAND ${CMAKE_COMMAND} -E make_directory "${INSTALL_CMAKE_DIR}"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_CURRENT_BINARY_DIR}/ComItemConfig.cmake"
        "${INSTALL_CMAKE_DIR}/"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_CURRENT_BINARY_DIR}/ComItemConfigVersion.cmake"
        "${INSTALL_CMAKE_DIR}/"
    COMMENT "Copying ComItem plugin files to Qt qml directory..."
)
