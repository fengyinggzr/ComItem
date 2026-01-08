import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComButton - 基础按钮组件
Button {
    id: root

    implicitWidth: 120
    implicitHeight: 36

    text: qsTr("Button")
    font.pixelSize: ComTheme.fontSizeMedium

    property alias radius: backRect.radius

    contentItem: Text {
        id: contentText
        text: root.text
        font: root.font
        color: ComTheme.textOnPrimary
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

        Behavior on color {
            ColorAnimation { duration: ComTheme.animationDuration }
        }
    }
}
