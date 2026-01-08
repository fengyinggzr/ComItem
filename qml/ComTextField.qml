import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComTextField - 输入框组件
TextField {
    id: root

    property bool error: false

    implicitWidth: 200
    implicitHeight: 36

    font.pixelSize: ComTheme.fontSizeMedium
    color: enabled ? ComTheme.textPrimary : ComTheme.textDisabled
    placeholderTextColor: ComTheme.textDisabled
    selectionColor: ComTheme.primaryLight
    selectedTextColor: ComTheme.textPrimary

    leftPadding: ComTheme.spacingLarge
    rightPadding: ComTheme.spacingLarge

    background: Rectangle {
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight
        radius: ComTheme.radiusMedium
        color: root.enabled ? ComTheme.background : ComTheme.backgroundDisabled
        border.width: root.activeFocus ? 2 : 1
        border.color: {
            if (root.error) return ComTheme.borderError
            if (root.activeFocus) return ComTheme.borderFocus
            return ComTheme.border
        }

        Behavior on border.color {
            ColorAnimation { duration: ComTheme.animationDuration }
        }
    }
}
