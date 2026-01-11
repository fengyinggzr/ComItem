# ComItem 使用 Attached Properties 主题系统

## ✅ 已实施方案

使用 **Attached Properties（附加属性）** 方式实现主题系统，这是 Qt Quick Controls 2 的官方推荐做法。

---

## 📋 技术实现

### C++ 实现
- **文件**: `cpp/ComThemeAttached.h` + `cpp/ComThemeAttached.cpp`
- **类型**: Attached Properties（QML_ATTACHED）
- **导出**: `COMITEM_EXPORT`（支持动态库导出）

### QML 使用
组件中直接使用 `ComTheme.xxx` 访问主题属性：

```qml
import QtQuick
import QtQuick.Controls
import ComItem  // 自动提供 ComTheme 附加属性

Button {
    background: Rectangle {
        color: ComTheme.primary           // 主色
        radius: ComTheme.radiusMedium     // 圆角
    }
    
    contentItem: Text {
        color: ComTheme.textOnPrimary     // 文字色
        font.pixelSize: ComTheme.fontSizeMedium
    }
}
```

---

## 🎨 可用主题属性

### 颜色属性
| 属性 | 值 | 说明 |
|------|-----|------|
| `ComTheme.primary` | #6366f1 | 主色 |
| `ComTheme.primaryHover` | #4f46e5 | 悬停色 |
| `ComTheme.primaryPressed` | #4338ca | 按下色 |
| `ComTheme.primaryLight` | #a5b4fc | 浅色 |
| `ComTheme.textPrimary` | #1e1b4b | 主要文字 |
| `ComTheme.textSecondary` | #6b7280 | 次要文字 |
| `ComTheme.textDisabled` | #9ca3af | 禁用文字 |
| `ComTheme.textOnPrimary` | #ffffff | 主色上的文字 |
| `ComTheme.background` | #ffffff | 背景色 |
| `ComTheme.backgroundHover` | #f5f3ff | 悬停背景 |
| `ComTheme.backgroundDisabled` | #f3f4f6 | 禁用背景 |
| `ComTheme.border` | #c7d2fe | 边框色 |
| `ComTheme.borderFocus` | #6366f1 | 聚焦边框 |
| `ComTheme.borderError` | #ef4444 | 错误边框 |
| `ComTheme.success` | #10b981 | 成功色 |
| `ComTheme.warning` | #f59e0b | 警告色 |
| `ComTheme.error` | #ef4444 | 错误色 |
| `ComTheme.shadow` | #1e1b4b20 | 阴影色 |

### 尺寸属性
| 属性 | 值 | 说明 |
|------|-----|------|
| `ComTheme.radiusSmall` | 4 | 小圆角 |
| `ComTheme.radiusMedium` | 6 | 中圆角 |
| `ComTheme.radiusLarge` | 8 | 大圆角 |
| `ComTheme.fontSizeSmall` | 12 | 小字号 |
| `ComTheme.fontSizeMedium` | 14 | 中字号 |
| `ComTheme.fontSizeLarge` | 16 | 大字号 |
| `ComTheme.spacingSmall` | 4 | 小间距 |
| `ComTheme.spacingMedium` | 8 | 中间距 |
| `ComTheme.spacingLarge` | 12 | 大间距 |
| `ComTheme.animationDuration` | 150 | 动画时长(ms) |

---

## 🚀 构建与使用

### 1. 构建项目
```powershell
# 启动 VS 开发环境
& "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Launch-VsDevShell.ps1" -Arch amd64

# 构建
cd d:\GitHub\ComItem
cmake --build build --config Debug

# Release 版本（可选）
cmake --build build --config Release
```

### 2. 在项目中使用
```qml
import QtQuick
import ComItem

Window {
    ComButton {
        text: "测试按钮"
        // ComTheme 自动可用，无需额外配置
    }
    
    ComTextField {
        placeholderText: "输入框"
    }
    
    ComCheckBox {
        text: "复选框"
    }
}
```

---

## ✅ 优势

### 1. **预览完美支持**
- ✅ Qt Creator 设计器预览正常
- ✅ Qt Design Studio 预览正常
- ✅ 运行时完全正常

### 2. **性能最优**
- 不创建额外的对象实例
- 属性值在编译时确定
- 内存占用最小

### 3. **代码简洁**
- 使用方式与单例完全相同
- 无需 import 额外模块
- 语法自然直观

### 4. **符合 Qt 标准**
- Qt Quick Controls Material 风格使用相同方式
- Qt Quick Controls Universal 风格使用相同方式
- 官方推荐的最佳实践

---

## 🔧 维护说明

### 修改主题颜色
编辑 `cpp/ComThemeAttached.h` 中的返回值：

```cpp
QColor primary() const { return QColor("#6366f1"); }  // 修改这里
QColor primaryHover() const { return QColor("#4f46e5"); }
// ...
```

重新构建后即可生效。

### 添加新的主题属性

1. 在 `ComThemeAttached` 类中添加 Q_PROPERTY：
```cpp
Q_PROPERTY(QColor newColor READ newColor CONSTANT)
```

2. 添加 getter 方法：
```cpp
QColor newColor() const { return QColor("#123456"); }
```

3. 重新构建即可在 QML 中使用 `ComTheme.newColor`

---

## 📦 文件清单

### 核心文件
- ✅ `cpp/ComThemeAttached.h` - 主题附加属性头文件
- ✅ `cpp/ComThemeAttached.cpp` - 实现文件
- ✅ `qmldir` - 模块定义（无需单例声明）

### 组件文件
- `qml/ComButton.qml`
- `qml/ComTextField.qml`
- `qml/ComCheckBox.qml`
- `qml/ComSwitch.qml`
- `qml/ComLabel.qml`
- `qml/ComCanvas.qml`
- `qml/ComComboBox.qml`

所有组件都已使用 `ComTheme.xxx` 语法，与 Attached Properties 完美兼容。

---

## 🎯 测试验证

### 预览测试
1. 在 Qt Design Studio 中打开任意 `.ui.qml` 文件
2. 拖拽 ComButton 到画布
3. 预览模式下应显示蓝紫色风格 ✅

### 运行测试
```powershell
cd example
qml Main.qml
```

应该看到所有组件显示蓝紫色主题。

---

## 📞 技术支持

如果遇到问题：
1. 确保已重新构建项目
2. 检查 `ComItemd.dll`（Debug）或 `ComItem.dll`（Release）是否存在
3. 验证 Qt 版本 >= 6.8
4. 查看构建日志确认 C++ 文件已编译

**优点总结**: Attached Properties 是解决预览问题的最佳方案，代码改动最小，性能最优，符合 Qt 官方标准！
