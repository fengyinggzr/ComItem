# ComItem - AI 编码助手指南

## 项目概述

ComItem 是一个 **Qt6 QML 插件库**，提供统一蓝紫色主题风格的可复用 UI 组件。支持 Qt Creator 设计模式拖拽使用，以动态库形式供其他项目引用。

## 架构

### 双层组件体系
- **C++ 组件** (`cpp/`): 继承 `QQuickPaintedItem`，使用 `QPainter` 绑定，适合需要自定义绑定逻辑的组件
  - 必须使用 `QML_ELEMENT` 宏注册
  - 导出宏: `COMITEM_EXPORT` (定义 `COMITEM_LIBRARY` 时导出)
- **纯 QML 组件** (`qml/`): 直接使用 QtQuick 构建，适合声明式 UI 组件

### 主题系统
- **ComTheme** (Singleton): 定义统一的蓝紫色主题色，包括主色、文字色、背景色、边框色、圆角、字体大小等
- 所有组件通过 `ComTheme.xxx` 引用主题属性，确保风格一致

### 组件清单
| 类型 | 组件 | 说明 |
|------|------|------|
| 主题 | `ComTheme` | 单例，统一主题色定义 |
| 按钮 | `BasicButton` | 蓝紫色主题按钮 |
| 输入 | `ComTextField` | 输入框 |
| 输入 | `ComComboBox` | 下拉选择框 |
| 控件 | `ComCheckBox` | 复选框 |
| 控件 | `ComSwitch` | 开关 |
| 显示 | `ComLabel` | 文字标签 |
| 显示 | `ComCanvas` | 自定义绘图 (rectangle/circle/triangle/star/wave/chart) |
| 容器 | `ComCard` | 卡片容器 |
| 显示 | `ComAvatar`, `ComBadge` | 头像、徽章 |

### 关键文件
- [qmldir](qmldir): 模块定义，列出所有公开组件及版本
- [qml/ComTheme.qml](qml/ComTheme.qml): 主题色定义 (Singleton)
- [designer/comitem.metainfo](designer/comitem.metainfo): Qt Creator 设计器元数据
- [CMakeLists.txt](CMakeLists.txt): 使用 `qt_add_qml_module` 构建插件

## 开发规范

### 添加新 C++ 组件
1. 在 `cpp/` 创建 `.h/.cpp` 文件（CMake 会自动扫描）
2. 继承 `QQuickPaintedItem`，添加 `QML_ELEMENT` 宏
3. 使用 `Q_PROPERTY` 声明属性，实现 getter/setter 和 `*Changed` 信号
4. 在 `designer/comitem.metainfo` 添加设计器条目

```cpp
// 标准 C++ 组件模板
class COMITEM_EXPORT ComXxx : public QQuickPaintedItem {
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
public:
    void paint(QPainter *painter) override;
signals:
    void textChanged();
};
```

### 添加新 QML 组件
1. 在 `qml/` 创建 `.qml` 文件
2. 在 `qmldir` 添加: `ComponentName 1.0 ComponentName.qml`
3. 在 `designer/comitem.metainfo` 添加设计器条目
4. **必须使用 ComTheme 引用颜色**，保持风格一致

```qml
// 标准 QML 组件模板
import QtQuick

Item {
    id: root
    // 使用主题色
    property color primaryColor: ComTheme.primary
    // ...
}
```

### 命名约定
- C++ 类名: `Com` 前缀 (如 `ComButton`, `ComProgressBar`)
- QML 文件: 与组件名相同 (如 `ComCard.qml`, `ComSwitch.qml`)
- 设计器分类: `ComItem - Basic`, `ComItem - Controls`, `ComItem - Input`, `ComItem - Display`

## 构建命令

```powershell
# 使用 VS 开发人员环境
& "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Launch-VsDevShell.ps1" -Arch amd64

# 配置
cmake -B build -G Ninja -DCMAKE_PREFIX_PATH="D:/Qt/Qt6.8/6.8.1/msvc2022_64"

# 构建（自动复制到 Qt SDK 目录）
cmake --build build --config Debug    # 生成带 d 后缀的库
cmake --build build --config Release

# 仅构建示例
cmake --build build --target ComItemExample
```

构建后文件自动复制到:
- `${QT_SDK}/qml/ComItem/` - QML 模块目录
- `${QT_SDK}/bin/` - 设计器依赖库
- `${QT_SDK}/lib/cmake/ComItem/` - find_package 配置

## 测试验证

运行示例项目验证组件: `example/` 目录包含独立可运行的测试程序
- 编辑 [example/Main.qml](example/Main.qml) 测试组件
- 示例依赖 `QT_QML_OUTPUT_DIRECTORY` 找到构建的模块

## 注意事项

- **Qt 版本**: 必须 >= 6.8
- **qmldir 无 prefer 指令**: 保持设计器兼容性
- **Debug/Release 后缀**: Debug 版本库名带 `d` 后缀 (如 `ComItemd.dll`)
- **头文件复制**: 仅 `.h` 文件会被复制到安装目录
- 修改组件后需重新构建才能在 Qt Creator 设计器中生效
- **VS 环境**: 必须使用 Developer PowerShell 构建，否则会报 `type_traits` 找不到
