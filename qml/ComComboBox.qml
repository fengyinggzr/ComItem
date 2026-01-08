import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComComboBox - 下拉框组件
ComboBox {
    id: root

    implicitWidth: 200
    implicitHeight: 36

    font.pixelSize: ComTheme.fontSizeMedium

    delegate: ItemDelegate {
        width: root.width
        height: 36

        contentItem: Text {
            text: root.textRole ? (Array.isArray(root.model)
                ? modelData[root.textRole]
                : model[root.textRole])
                : modelData
            color: highlighted ? ComTheme.textOnPrimary : ComTheme.textPrimary
            font: root.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            leftPadding: ComTheme.spacingLarge
        }

        background: Rectangle {
            color: highlighted ? ComTheme.primary : (hovered ? ComTheme.backgroundHover : "transparent")
            radius: ComTheme.radiusSmall
        }

        highlighted: root.highlightedIndex === index
    }

    indicator: Item {
        x: root.width - width - ComTheme.spacingMedium
        y: (root.height - height) / 2
        width: 12
        height: 12

        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.strokeStyle = root.enabled ? ComTheme.textSecondary : ComTheme.textDisabled
                ctx.lineWidth = 2
                ctx.lineCap = "round"
                ctx.lineJoin = "round"
                ctx.beginPath()
                ctx.moveTo(2, 4)
                ctx.lineTo(6, 8)
                ctx.lineTo(10, 4)
                ctx.stroke()
            }
        }
    }

    contentItem: Text {
        leftPadding: ComTheme.spacingLarge
        rightPadding: root.indicator.width + ComTheme.spacingLarge

        text: root.displayText
        font: root.font
        color: root.enabled ? ComTheme.textPrimary : ComTheme.textDisabled
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight
        radius: ComTheme.radiusMedium
        color: root.enabled ? ComTheme.background : ComTheme.backgroundDisabled
        border.width: root.visualFocus || root.down ? 2 : 1
        border.color: (root.visualFocus || root.down) ? ComTheme.borderFocus : ComTheme.border

        Behavior on border.color {
            ColorAnimation { duration: ComTheme.animationDuration }
        }
    }

    popup: Popup {
        y: root.height + 4
        width: root.width
        implicitHeight: contentItem.implicitHeight + 8
        padding: 4

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: root.popup.visible ? root.delegateModel : null
            currentIndex: root.highlightedIndex
            ScrollIndicator.vertical: ScrollIndicator {}
        }

        background: Rectangle {
            radius: ComTheme.radiusMedium
            color: ComTheme.background
            border.color: ComTheme.border
            border.width: 1

            // 阴影效果
            layer.enabled: true
            layer.effect: Item {
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -4
                    radius: ComTheme.radiusMedium + 4
                    color: ComTheme.shadow
                    z: -1
                }
            }
        }
    }
}
