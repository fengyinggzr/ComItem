# ComItem

## 介绍

ComItem 是一个 Qt6 QML 插件库，提供统一蓝紫色主题风格的可复用 UI 组件。支持 Qt Creator 和 Qt Design Studio 设计模式拖拽使用，以动态库形式供其他项目引用。

## 特性

- ✨ **统一蓝紫色主题** - 基于 Attached Properties 实现的主题系统
- 🎨 **设计器完美支持** - Qt Creator 和 Qt Design Studio 预览完全正常
- 🚀 **高性能** - C++ 实现的附加属性，零额外开销
- 📦 **开箱即用** - 拖拽即可使用，无需额外配置

## 软件架构

### 双层组件体系
- **C++ 组件** (`cpp/`) - 继承 `QQuickPaintedItem`，适合需要自定义绘制的组件
- **QML 组件** (`qml/`) - 纯 QML 实现，适合声明式 UI 组件

### 主题系统
- **ComTheme Attached Properties** - C++ 实现的附加属性，提供统一的蓝紫色主题
- 所有组件通过 `ComTheme.xxx` 访问主题属性
- 支持设计器预览和运行时使用

## 依赖

- Qt 6.8 或更高版本
- CMake 3.16 或更高版本
- C++20 编译器
- Visual Studio 2022（Windows）

## 编译安装

### 1. 启动开发环境（Windows）

```powershell
# 使用 VS 开发人员 PowerShell
& "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Launch-VsDevShell.ps1" -Arch amd64
```

### 2. 配置和构建

```powershell
# 配置
cmake -B build -G Ninja -DCMAKE_PREFIX_PATH="D:/Qt/Qt6.8/6.8.1/msvc2022_64"

# 构建 Debug 版本
cmake --build build --config Debug

# 构建 Release 版本
cmake --build build --config Release
```

### 3. 自动安装

构建后会自动复制到 Qt SDK 和 Qt Design Studio 目录：
- `${QT_SDK}/qml/ComItem/` - QML 模块
- `${QT_SDK}/bin/` - 动态库
- `${QT_DESIGN_STUDIO}/qml/ComItem/` - 设计器支持

## 在其他项目中使用

### QML 中使用

```qml
import QtQuick
import QtQuick.Window
import ComItem

Window {
    width: 800
    height: 600
    visible: true
    title: "ComItem Demo"

    Column {
        anchors.centerIn: parent
        spacing: 20

        ComButton {
            text: "测试按钮"
            // ComTheme 自动可用，显示蓝紫色主题
        }

        ComTextField {
            placeholderText: "输入框"
            width: 200
        }

        ComCheckBox {
            text: "复选框"
        }

        ComSwitch {
            checked: true
        }
    }
}
```

### 使用主题系统

所有组件都使用 `ComTheme` 附加属性访问统一的主题颜色：

```qml
import ComItem

Rectangle {
    color: ComTheme.primary           // 主色 #6366f1
    radius: ComTheme.radiusMedium     // 圆角 6
    
    Text {
        color: ComTheme.textOnPrimary  // 白色文字
        font.pixelSize: ComTheme.fontSizeMedium  // 14
    }
}
```

**可用组件**:
- `ComButton` - 蓝紫色按钮
- `ComTextField` - 输入框
- `ComCheckBox` - 复选框  
- `ComSwitch` - 开关
- `ComLabel` - 文字标签
- `ComCanvas` - 自定义绘图
- `ComComboBox` - 下拉选择

详细的主题属性列表请查看: [ComTheme 使用说明](docs/ComTheme_AttachedProperties使用说明.md)

## Qt Creator / Qt Design Studio 设计模式

安装后，在设计器中：

1. 打开任意 QML 文件
2. 切换到**设计模式**
3. 在组件栏找到 **"ComItem"** 分类
4. 拖放组件到画布
5. ✅ 预览中即可看到蓝紫色主题风格

## 目录结构

```
ComItem/
├── CMakeLists.txt          # CMake 构建配置
├── qmldir                  # QML 模块定义
├── cpp/                    # C++ 组件源码
│   ├── ComThemeAttached.h  # 主题附加属性
│   ├── ComThemeAttached.cpp
│   ├── ComBasicButton.h
│   ├── ComBasicButton.cpp
│   └── ...
├── qml/                    # QML 组件
│   ├── ComButton.qml
│   ├── ComTextField.qml
│   ├── ComCheckBox.qml
│   └── ...
├── designer/               # Qt Creator 设计器支持
│   ├── comitem.metainfo    # 设计器元信息
│   └── images/             # 组件图标
├── example/                # 示例项目
│   ├── Main.qml
│   └── ...
└── docs/                   # 文档
    └── ComTheme_AttachedProperties使用说明.md
└── example/                # 示例项目
    ├── example.cpp
    └── example.qml
```

## 许可证

MIT License
