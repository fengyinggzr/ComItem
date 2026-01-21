# QQuickAttachedPropertyPropagator 与普通附加属性详解

## 概述

本文档详细介绍 Qt 中 `QQuickAttachedPropertyPropagator` 与普通附加属性实现的区别，以 ComItem 项目中的 `ComTheme` 和 Qt 官方 `QQuickMaterialStyle` 为例。

---

## 1. 两种实现方式对比

### 1.1 核心区别

| 特性 | 普通附加属性 (ComTheme) | QQuickAttachedPropertyPropagator (Material) |
|------|------------------------|---------------------------------------------|
| **值传播** | ❌ 不传播 | ✅ 自动向子项传播 |
| **继承链** | ❌ 每个对象独立 | ✅ 子项自动继承父项设置 |
| **局部覆盖** | ❌ 不支持 | ✅ 子项可覆盖特定属性 |
| **运行时修改** | ❌ CONSTANT 属性 | ✅ 动态响应变化 |
| **性能开销** | 更轻量 | 稍重（维护继承链） |
| **实现复杂度** | 简单 | 复杂 |

### 1.2 当前 ComTheme 实现分析

```cpp
// 当前实现：每个对象创建独立的附加实例，返回硬编码常量值
class COMITEM_EXPORT ComThemeAttached : public QObject
{
    Q_OBJECT
    QML_ANONYMOUS
    
    // 所有属性都是 CONSTANT - 无法运行时修改
    Q_PROPERTY(QColor primary READ primary CONSTANT)
    // ...
    
public:
    // 直接返回硬编码值
    QColor primary() const { return QColor("#6366f1"); }
};

class COMITEM_EXPORT ComTheme : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_ATTACHED(ComThemeAttached)
    
    static ComThemeAttached *qmlAttachedProperties(QObject *object)
    {
        // 每次访问都创建新的独立实例
        return new ComThemeAttached(object);
    }
};
```

**QML 中的行为：**
```qml
// 每次访问 ComTheme 都创建独立实例，返回相同的硬编码值
Rectangle {
    color: ComTheme.primary  // 创建 ComThemeAttached 实例 A
    
    Text {
        color: ComTheme.textPrimary  // 创建实例 B，与 A 完全独立
    }
}
```

### 1.3 QQuickAttachedPropertyPropagator 实现原理

```cpp
// Qt Material 风格的实现
class QQuickMaterialStyle : public QQuickAttachedPropertyPropagator
{
    Q_OBJECT
    QML_ELEMENT
    QML_ATTACHED(QQuickMaterialStyle)
    
    // 属性支持 WRITE 和 RESET
    Q_PROPERTY(Theme theme READ theme WRITE setTheme RESET resetTheme NOTIFY themeChanged)
    
protected:
    // 核心：当父级附加属性变化时自动调用
    void attachedParentChange(QQuickAttachedPropertyPropagator *newParent,
                              QQuickAttachedPropertyPropagator *oldParent) override;
};
```

**QML 中的行为：**
```qml
ApplicationWindow {
    Material.theme: Material.Dark    // 设置一次
    Material.accent: Material.Purple
    
    Button {
        // 自动继承 Dark 主题和 Purple 强调色，无需显式设置
    }
    
    Pane {
        Material.accent: Material.Teal  // 局部覆盖强调色
        
        Button {
            // 继承 Dark 主题，但使用 Teal 强调色
        }
    }
}
```

---

## 2. 继承链可视化

### 2.1 普通附加属性（当前 ComTheme）

```
┌─────────────────────────────────────────────────────────┐
│                    独立实例模型                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   Window ─────────────────► ComThemeAttached (实例 1)   │
│       │                           ↓                     │
│       │                     primary: #6366f1            │
│       │                                                 │
│       ├── Button ─────────► ComThemeAttached (实例 2)   │
│       │                           ↓                     │
│       │                     primary: #6366f1            │
│       │                                                 │
│       └── Pane ───────────► ComThemeAttached (实例 3)   │
│               │                   ↓                     │
│               │             primary: #6366f1            │
│               │                                         │
│               └── Button ─► ComThemeAttached (实例 4)   │
│                                   ↓                     │
│                             primary: #6366f1            │
│                                                         │
│   ⚠️ 所有实例独立，返回相同的硬编码值，无法局部覆盖      │
└─────────────────────────────────────────────────────────┘
```

### 2.2 QQuickAttachedPropertyPropagator 继承链

```
┌─────────────────────────────────────────────────────────┐
│                    继承传播模型                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   Window (theme=Dark, accent=Purple)                    │
│       │                                                 │
│       │  ← 值向下传播                                   │
│       ▼                                                 │
│   ┌─────────────────────────────────────────────┐       │
│   │ Button                                      │       │
│   │   theme: Dark (继承)                        │       │
│   │   accent: Purple (继承)                     │       │
│   └─────────────────────────────────────────────┘       │
│                                                         │
│   ┌─────────────────────────────────────────────┐       │
│   │ Pane (accent=Teal 显式覆盖)                 │       │
│   │   theme: Dark (继承)                        │       │
│   │   accent: Teal (覆盖) ←── 局部修改          │       │
│   │       │                                     │       │
│   │       ▼                                     │       │
│   │   ┌─────────────────────────────────────┐   │       │
│   │   │ Button                              │   │       │
│   │   │   theme: Dark (继承自 Window)       │   │       │
│   │   │   accent: Teal (继承自 Pane)        │   │       │
│   │   └─────────────────────────────────────┘   │       │
│   └─────────────────────────────────────────────┘       │
│                                                         │
│   ✅ 支持继承 + 局部覆盖 + 动态变化通知                  │
└─────────────────────────────────────────────────────────┘
```

---

## 3. 升级 ComTheme 到 Propagator 模式（参考）

如需支持主题继承和局部覆盖，可参考以下实现：

### 3.1 头文件

```cpp
// ComThemeAttached.h
#ifndef COMTHEMEATTACHED_H
#define COMTHEMEATTACHED_H

#include "comitem_global.h"
#include <QtQuickControls2Impl/private/qquickattachedpropertypropagator_p.h>
#include <QColor>
#include <QQmlEngine>

class COMITEM_EXPORT ComTheme : public QQuickAttachedPropertyPropagator
{
    Q_OBJECT
    QML_ELEMENT
    QML_ATTACHED(ComTheme)

    // 可配置属性 - 支持继承和局部覆盖
    Q_PROPERTY(QColor primary READ primary WRITE setPrimary 
               RESET resetPrimary NOTIFY primaryChanged FINAL)
    Q_PROPERTY(QColor textPrimary READ textPrimary WRITE setTextPrimary 
               RESET resetTextPrimary NOTIFY textPrimaryChanged FINAL)
    // ... 其他属性

public:
    explicit ComTheme(QObject *parent = nullptr);

    static ComTheme *qmlAttachedProperties(QObject *object);

    // primary 属性
    QColor primary() const;
    void setPrimary(const QColor &color);
    void resetPrimary();  // 重置为继承父级的值

    // textPrimary 属性
    QColor textPrimary() const;
    void setTextPrimary(const QColor &color);
    void resetTextPrimary();

signals:
    void primaryChanged();
    void textPrimaryChanged();

protected:
    // 核心：当父级附加属性变化时调用
    void attachedParentChange(QQuickAttachedPropertyPropagator *newParent,
                              QQuickAttachedPropertyPropagator *oldParent) override;

private:
    void inheritPrimary();
    void inheritTextPrimary();

    // 显式设置标记
    bool m_explicitPrimary = false;
    bool m_explicitTextPrimary = false;

    // 属性值
    QColor m_primary;
    QColor m_textPrimary;

    // 默认值
    static constexpr const char* DefaultPrimary = "#6366f1";
    static constexpr const char* DefaultTextPrimary = "#1e1b4b";
};

#endif // COMTHEMEATTACHED_H
```

### 3.2 实现文件

```cpp
// ComThemeAttached.cpp
#include "ComThemeAttached.h"

ComTheme::ComTheme(QObject *parent)
    : QQuickAttachedPropertyPropagator(parent)
    , m_primary(DefaultPrimary)
    , m_textPrimary(DefaultTextPrimary)
{
    // 初始化时从父级继承
    initialize();
}

ComTheme *ComTheme::qmlAttachedProperties(QObject *object)
{
    return new ComTheme(object);
}

void ComTheme::attachedParentChange(QQuickAttachedPropertyPropagator *newParent,
                                     QQuickAttachedPropertyPropagator *oldParent)
{
    Q_UNUSED(oldParent)
    Q_UNUSED(newParent)
    
    // 父级变化时，重新继承未显式设置的属性
    if (!m_explicitPrimary)
        inheritPrimary();
    if (!m_explicitTextPrimary)
        inheritTextPrimary();
}

// ========== primary 属性实现 ==========
QColor ComTheme::primary() const
{
    return m_primary;
}

void ComTheme::setPrimary(const QColor &color)
{
    m_explicitPrimary = true;
    if (m_primary == color)
        return;
    m_primary = color;
    emit primaryChanged();
    
    // 传播给子级
    propagateAttachedProperties();
}

void ComTheme::resetPrimary()
{
    m_explicitPrimary = false;
    inheritPrimary();
}

void ComTheme::inheritPrimary()
{
    QColor inherited = DefaultPrimary;
    if (auto *parent = qobject_cast<ComTheme *>(attachedParent()))
        inherited = parent->primary();
    
    if (m_primary != inherited) {
        m_primary = inherited;
        emit primaryChanged();
    }
}

// ... textPrimary 等其他属性类似实现
```

### 3.3 升级后的 QML 用法

```qml
// 升级后支持继承和局部覆盖
ApplicationWindow {
    ComTheme.primary: "#6366f1"  // 全局设置
    
    Rectangle {
        color: ComTheme.primary  // 继承 #6366f1
        
        Pane {
            ComTheme.primary: "#ef4444"  // 局部覆盖为红色
            
            Button {
                // 自动继承 #ef4444
                background: Rectangle {
                    color: ComTheme.primary
                }
            }
        }
    }
}
```

---

## 4. 选择建议

### 4.1 保持当前实现的场景

- ✅ 全局统一主题，不需要局部覆盖
- ✅ 简单场景，性能优先
- ✅ 仅需深色/浅色两种主题切换（可用全局单例）

### 4.2 升级到 Propagator 的场景

- 🔄 需要主题嵌套（如深色界面内嵌浅色卡片）
- 🔄 支持运行时动态切换并自动更新 UI
- 🔄 需要组件级样式覆盖
- 🔄 实现类似 Material/Universal 的复杂主题系统

---

## 5. 注意事项

1. **私有 API**：`QQuickAttachedPropertyPropagator` 位于 `QtQuickControls2Impl` 的私有头文件中，跨 Qt 版本可能不兼容

2. **CMake 依赖**：需添加 `Qt6::QuickControls2Impl` 链接
   ```cmake
   target_link_libraries(ComItem PRIVATE Qt6::QuickControls2Impl)
   ```

3. **性能考量**：Propagator 需要维护父子关系和信号连接，大量组件时有额外开销

---

## 6. 相关文件

- 当前实现：`cpp/ComThemeAttached.h`、`cpp/ComThemeAttached.cpp`
- 主题使用说明：`docs/ComTheme_AttachedProperties使用说明.md`
