pragma Singleton
import QtQuick

// ComTheme - 统一主题色定义
QtObject {
    // 主色调 - 蓝紫色系
    readonly property color primary: "#6366f1"           // 主色
    readonly property color primaryHover: "#4f46e5"      // 悬停色
    readonly property color primaryPressed: "#4338ca"    // 按下色
    readonly property color primaryLight: "#a5b4fc"      // 浅色
    readonly property color primaryLighter: "#e0e7ff"    // 更浅色

    // 文字颜色
    readonly property color textPrimary: "#1e1b4b"       // 主要文字
    readonly property color textSecondary: "#6b7280"     // 次要文字
    readonly property color textDisabled: "#9ca3af"      // 禁用文字
    readonly property color textOnPrimary: "#ffffff"     // 主色上的文字

    // 背景颜色
    readonly property color background: "#ffffff"        // 背景色
    readonly property color backgroundHover: "#f5f3ff"   // 悬停背景
    readonly property color backgroundDisabled: "#f3f4f6" // 禁用背景

    // 边框颜色
    readonly property color border: "#c7d2fe"            // 边框色
    readonly property color borderFocus: "#6366f1"       // 聚焦边框
    readonly property color borderError: "#ef4444"       // 错误边框

    // 状态颜色
    readonly property color success: "#10b981"           // 成功
    readonly property color warning: "#f59e0b"           // 警告
    readonly property color error: "#ef4444"             // 错误

    // 阴影
    readonly property color shadow: "#1e1b4b20"          // 阴影色

    // 通用属性
    readonly property int radiusSmall: 4
    readonly property int radiusMedium: 6
    readonly property int radiusLarge: 8

    readonly property int fontSizeSmall: 12
    readonly property int fontSizeMedium: 14
    readonly property int fontSizeLarge: 16

    readonly property int spacingSmall: 4
    readonly property int spacingMedium: 8
    readonly property int spacingLarge: 12

    readonly property int animationDuration: 150
}
