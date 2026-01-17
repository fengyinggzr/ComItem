# ComItem AI Coding Instructions

**ComItem** 是一个 Qt6 QML 插件库，提供统一蓝紫色主题的 UI 组件。采用 C++/QML 双层架构，支持 Qt Creator 和 Qt Design Studio。

## 架构概览

### 双层组件系统
| 层级 | 目录 | 用途 | 示例 |
|------|------|------|------|
| C++ | `cpp/` | 自定义绘制 (`QQuickPaintedItem`)、复杂逻辑 | `ComProgressBar`, `ComThemeAttached` |
| QML | `qml/` | 声明式 UI，继承 Qt Quick Controls | `ComButton.qml`, `ComSwitch.qml` |

### ComTheme 主题系统（核心）
**所有视觉组件必须使用 ComTheme 附加属性**，定义于 `cpp/ComThemeAttached.h`：
```qml
// 颜色
ComTheme.primary / .primaryHover / .primaryPressed / .primaryLight
ComTheme.textPrimary / .textSecondary / .textDisabled / .textOnPrimary
ComTheme.background / .backgroundHover / .backgroundDisabled
ComTheme.border / .borderFocus / .borderError
ComTheme.success / .warning / .error

// 尺寸
ComTheme.radiusSmall(4) / .radiusMedium(6) / .radiusLarge(8)
ComTheme.spacingSmall(4) / .spacingMedium(8) / .spacingLarge(12)
ComTheme.fontSizeSmall(12) / .fontSizeMedium(14) / .fontSizeLarge(16)
ComTheme.animationDuration(150)
```

## 开发工作流

### 构建命令（Windows + Ninja）
```powershell
# 配置
cmake -B build -G Ninja -DCMAKE_PREFIX_PATH="D:/Qt/Qt6.8/6.8.1/msvc2022_64"
# 构建
cmake --build build --config Debug
```
⚠️ **构建会自动安装到 Qt SDK 和 Qt Design Studio 目录**

### 运行示例
`example/` 是独立 CMake 项目，需先构建主项目：
```powershell
cd example && cmake -B build -G Ninja -DCMAKE_PREFIX_PATH="<QT_PATH>" && cmake --build build
.\build\Debug\ComItemExample.exe
```

## 编码规范

### QML 组件模板
```qml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComXxx - 组件描述
ControlBase {  // 如 Button, TextField, Switch
    id: root

    implicitWidth: 120
    implicitHeight: 36

    // 使用 ComTheme 进行所有样式设置
    background: Rectangle {
        color: root.enabled ? ComTheme.primary : ComTheme.backgroundDisabled
        radius: ComTheme.radiusMedium
        border.color: ComTheme.border
        
        Behavior on color {
            ColorAnimation { duration: ComTheme.animationDuration }
        }
    }
}
```

### C++ 组件模板
```cpp
#include "comitem_global.h"
#include <QtQuick/QQuickPaintedItem>
#include <QtQml/qqmlregistration.h>

class COMITEM_EXPORT ComXxx : public QQuickPaintedItem {
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(type name READ name WRITE setName NOTIFY nameChanged)
    // ...
};
```

## 添加新组件

### QML 组件
1. 创建 `qml/ComNewItem.qml`（文件名必须 `Com` 前缀）
2. 使用 `ComTheme` 进行所有样式
3. CMake GLOB 自动扫描，必要时重新配置

### C++ 组件
1. 在 `cpp/` 创建 `.h/.cpp`
2. 使用 `COMITEM_EXPORT` + `QML_ELEMENT` 宏
3. 重新配置 CMake

### 设计器支持
新组件需在 `designer/comitem.metainfo` 添加条目：
```
Type {
    name: "ComItem.ComNewItem"
    icon: "images/item-icon16.svg"
    ItemLibraryEntry {
        name: "ComNewItem"
        category: "ComItem - Controls"
        requiredImport: "ComItem"
        Property { name: "width"; type: "int"; value: 100 }
    }
}
```

## 调试

- **组件未找到**: 检查 CMake 是否扫描到文件，运行 `cmake -B build` 重新配置
- **主题不生效**: 确认使用 `ComTheme.xxx` 而非硬编码颜色
- **设计器预览失败**: 查看 `docs/快速解决预览问题.md`
