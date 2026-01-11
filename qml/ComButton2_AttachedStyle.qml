import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import ComItem

// ComButton2 - 使用 Attached Properties 的按钮组件
Button {
    id: root

    implicitWidth: 120
    implicitHeight: 36

    text: qsTr("Button")
    font.pixelSize: ComTheme.fontSizeMedium  // 使用附加属性

    property alias radius: backRect.radius

    contentItem: Text {
        id: contentText
        text: root.text
        font: root.font
        color: root.enabled ? ComTheme.textOnPrimary : ComTheme.textDisabled
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        id: backRect
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight
        radius: ComTheme.radiusMedium
        color: {
            if (!root.enabled) return ComTheme.backgroundDisabled
            if (root.pressed) return ComTheme.primaryPressed
            if (root.hovered) return ComTheme.primaryHover
            return ComTheme.primary
        }
        border.width: root.enabled ? 0 : 1
        border.color: ComTheme.border

        Behavior on color {
            ColorAnimation { duration: ComTheme.animationDuration }
        }
    }
}
