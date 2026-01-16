import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComLineTextField - 只有下划线的输入框组件
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

    // 底部线条样式通常左右边距较小
    leftPadding: 4
    rightPadding: 4
    
    background: Item {
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight

        // 下划线
        Rectangle {
            id: indicator
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: root.activeFocus ? 2 : 1
            
            color: {
                if (!root.enabled) return ComTheme.border
                if (root.error) return ComTheme.borderError
                if (root.activeFocus) return ComTheme.borderFocus
                if (root.hovered) return ComTheme.textSecondary // 悬停稍微加深
                return ComTheme.border
            }

            Behavior on color {
                ColorAnimation { duration: ComTheme.animationDuration }
            }
            
            Behavior on height {
                NumberAnimation { duration: ComTheme.animationDuration }
            }
        }
    }
}
