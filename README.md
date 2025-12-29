# ComItem

## 介绍

ComItem 是一个 Qt6 QML 插件库，提供可复用的 QML 组件。该插件支持 Qt Creator 设计模式，可以在组件栏中拖放使用。

## 软件架构

- **ComItem** - 基于 `QQuickPaintedItem` 的 C++ 组件
- **ComItemControls** - 纯 QML 组件
- 支持 Qt Creator 设计模式集成
- 支持动态库方式供其他项目使用

## 依赖

- Qt 6.8 或更高版本
- CMake 3.16 或更高版本
- C++20 编译器

## 编译安装

### 1. 配置和构建

```bash
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .
```

### 2. 安装到 Qt SDK

默认安装到 Qt SDK 的 qml 目录：

```bash
cmake --install .
```

或指定安装目录：

```bash
cmake --install . --prefix "D:/Qt/Qt6.8/6.8.1/msvc2022_64"
```

### 3. 自定义安装路径

```bash
cmake .. -DINSTALL_QML_DIR="D:/MyPlugins/qml/ComItem"
cmake --build .
cmake --install .
```

## 在其他项目中使用

### CMakeLists.txt 配置

```cmake
find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_add_executable(MyApp main.cpp)
qt_add_qml_module(MyApp
    URI MyApp
    VERSION 1.0
    QML_FILES main.qml
)

target_link_libraries(MyApp PRIVATE Qt6::Quick)
```

### QML 中使用

```qml
import QtQuick
import ComItem

Window {
    width: 640
    height: 480
    visible: true

    ComItemControls {
        width: 100
        height: 100
    }

    ComItem {
        x: 120
        width: 100
        height: 100
    }
}
```

## Qt Creator 设计模式支持

安装后，在 Qt Creator 的设计模式中：

1. 打开任意 QML 文件
2. 切换到设计模式
3. 在左侧组件栏找到 **"ComItem - Controls"** 分类
4. 拖放 `ComItem` 或 `ComItemControls` 组件到画布

## 目录结构

```
ComItem/
├── CMakeLists.txt          # CMake 构建配置
├── comitem.h               # C++ 组件头文件
├── comitem.cpp             # C++ 组件实现
├── ComItemControls.qml     # QML 组件
├── qmldir                  # QML 模块描述文件
├── designer/               # Qt Creator 设计器支持
│   ├── comitem.metainfo    # 设计器元信息
│   └── images/             # 组件图标
└── example/                # 示例项目
    ├── example.cpp
    └── example.qml
```

## 许可证

MIT License
