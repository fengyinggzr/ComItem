import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComCheckBox - 复选框组件
CheckBox {
    id: root

    implicitWidth: contentRow.implicitWidth
    implicitHeight: Math.max(checkboxIndicator.height, contentText.implicitHeight)

    indicator: Rectangle {
        id: checkboxIndicator
        width: 20
        height: 20
        x: 0
        y: (root.height - height) / 2
        radius: ComTheme.radiusSmall
        color: {
            if (!root.enabled) return ComTheme.backgroundDisabled
            if (root.checked) return ComTheme.primary
            return ComTheme.background
        }
        border.width: root.checked ? 0 : 1
        border.color: {
            if (!root.enabled) return ComTheme.textDisabled
            if (root.hovered) return ComTheme.primary
            return ComTheme.border
        }

        Behavior on color {
            ColorAnimation { duration: ComTheme.animationDuration }
        }

        // 勾选图标
        Item {
            anchors.centerIn: parent
            width: 12
            height: 12
            opacity: root.checked ? 1 : 0

            Behavior on opacity {
                NumberAnimation { duration: ComTheme.animationDuration }
            }

            // 使用Canvas绘制勾选标记
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.strokeStyle = ComTheme.textOnPrimary
                    ctx.lineWidth = 2
                    ctx.lineCap = "round"
                    ctx.lineJoin = "round"
                    ctx.beginPath()
                    ctx.moveTo(2, 6)
                    ctx.lineTo(5, 10)
                    ctx.lineTo(10, 2)
                    ctx.stroke()
                }
            }
        }
    }

    contentItem: Row {
        id: contentRow
        spacing: ComTheme.spacingMedium
        leftPadding: checkboxIndicator.width + ComTheme.spacingMedium

        Text {
            id: contentText
            text: root.text
            font.pixelSize: ComTheme.fontSizeMedium
            color: root.enabled ? ComTheme.textPrimary : ComTheme.textDisabled
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
