# ComItem Example

这是一个用于调试和测试 ComItem QML 插件的示例项目。

## 构建步骤

### 1. 首先构建主项目 ComItem

```bash
cd d:\Gitee\ComItem
mkdir build
cd build
cmake ..
cmake --build .
```

### 2. 构建并运行示例项目

```bash
cd d:\Gitee\ComItem\example
mkdir build
cd build
cmake ..
cmake --build .
```

### 3. 运行示例

```bash
# Windows
.\Debug\ComItemExample.exe
# 或
.\Release\ComItemExample.exe
```

## 说明

- 示例项目会自动从 `../build/qml` 目录加载 ComItem 插件
- 如果插件加载失败，请确保已先构建主项目
- 控制台会输出当前的 QML 导入路径，便于调试

## 组件测试

示例中包含以下组件的测试：

- **ComSwitch** - 开关组件
- **ComCard** - 卡片组件
- **ComAvatar** - 头像组件
- **ComBadge** - 徽章组件

可以根据需要修改 `Main.qml` 来测试其他组件。
