import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComButton3 - 内联样式版本（设计器预览最可靠）
Button {
    id: root

    // 主题颜色直接定义在组件内部
    readonly property color themePrimary: "#6366f1"
    readonly property color themePrimaryHover: "#4f46e5"
    readonly property color themePrimaryPressed: "#4338ca"
    readonly property color themeTextOnPrimary: "#ffffff"
    readonly property color themeTextDisabled: "#9ca3af"
    readonly property color themeBackgroundDisabled: "#f3f4f6"
    readonly property color themeBorder: "#c7d2fe"
    readonly property int themeRadiusMedium: 6
    readonly property int themeFontSizeMedium: 14
    readonly property int themeAnimationDuration: 150

    implicitWidth: 120
    implicitHeight: 36

    text: qsTr("Button")
    font.pixelSize: themeFontSizeMedium

    property alias radius: backRect.radius

    contentItem: Text {
        id: contentText
        text: root.text
        font: root.font
        color: root.enabled ? root.themeTextOnPrimary : root.themeTextDisabled
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        id: backRect
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight
        radius: root.themeRadiusMedium
        color: {
            if (!root.enabled) return root.themeBackgroundDisabled
            if (root.pressed) return root.themePrimaryPressed
            if (root.hovered) return root.themePrimaryHover
            return root.themePrimary
        }
        border.width: root.enabled ? 0 : 1
        border.color: root.themeBorder

        Behavior on color {
            ColorAnimation { duration: root.themeAnimationDuration }
        }
    }
}
