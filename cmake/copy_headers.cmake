# copy_headers.cmake - 复制头文件脚本
# 用法: cmake -P copy_headers.cmake <源目录> <目标目录>

# 获取命令行参数
set(SRC_DIR ${CMAKE_ARGV3})
set(DST_DIR ${CMAKE_ARGV4})

# 获取所有 .h 文件
file(GLOB HEADER_FILES "${SRC_DIR}/*.h")

# 复制每个头文件
foreach(HEADER ${HEADER_FILES})
    get_filename_component(FILENAME ${HEADER} NAME)
    file(COPY ${HEADER} DESTINATION ${DST_DIR})
    message(STATUS "Copied: ${FILENAME}")
endforeach()
