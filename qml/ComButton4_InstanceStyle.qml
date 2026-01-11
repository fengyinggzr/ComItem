import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComButton4 - 使用 QtObject 实例的版本
Button {
    id: root

    // 在组件内部创建主题实例
    property var theme: ComThemeInstance {}

    implicitWidth: 120
    implicitHeight: 36

    text: qsTr("Button")
    font.pixelSize: theme.fontSizeMedium

    property alias radius: backRect.radius

    contentItem: Text {
        id: contentText
        text: root.text
        font: root.font
        color: root.enabled ? root.theme.textOnPrimary : root.theme.textDisabled
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        id: backRect
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight
        radius: root.theme.radiusMedium
        color: {
            if (!root.enabled) return root.theme.backgroundDisabled
            if (root.pressed) return root.theme.primaryPressed
            if (root.hovered) return root.theme.primaryHover
            return root.theme.primary
        }
        border.width: root.enabled ? 0 : 1
        border.color: root.theme.border

        Behavior on color {
            ColorAnimation { duration: root.theme.animationDuration }
        }
    }
}
