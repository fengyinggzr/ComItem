import QtQuick

// ComThemeInstance - 非单例主题对象
QtObject {
    // 主色调 - 蓝紫色系
    readonly property color primary: "#6366f1"
    readonly property color primaryHover: "#4f46e5"
    readonly property color primaryPressed: "#4338ca"
    readonly property color primaryLight: "#a5b4fc"
    readonly property color primaryLighter: "#e0e7ff"

    // 文字颜色
    readonly property color textPrimary: "#1e1b4b"
    readonly property color textSecondary: "#6b7280"
    readonly property color textDisabled: "#9ca3af"
    readonly property color textOnPrimary: "#ffffff"

    // 背景颜色
    readonly property color background: "#ffffff"
    readonly property color backgroundHover: "#f5f3ff"
    readonly property color backgroundDisabled: "#f3f4f6"

    // 边框颜色
    readonly property color border: "#c7d2fe"
    readonly property color borderFocus: "#6366f1"
    readonly property color borderError: "#ef4444"

    // 状态颜色
    readonly property color success: "#10b981"
    readonly property color warning: "#f59e0b"
    readonly property color error: "#ef4444"

    // 阴影
    readonly property color shadow: "#1e1b4b20"

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
