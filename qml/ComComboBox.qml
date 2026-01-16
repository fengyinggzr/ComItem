import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComComboBox - 下拉框组件
ComboBox {
    id: root

    // Popup 背景透明度控制，false 为非透明（默认），true 为透明
    property bool popupTransparent: false
    // Popup 显示的行数，默认3行，超出部分可滚动
    property int visibleItemCount: 3
    // 每行高度
    readonly property int itemHeight: 36

    implicitWidth: 200
    implicitHeight: 36

    font.pixelSize: ComTheme.fontSizeMedium

    delegate: ItemDelegate {
        width: root.width - 8  // 减去 padding
        height: root.itemHeight

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
            color: highlighted ? ComTheme.primary
                : (hovered ? ComTheme.backgroundHover
                    : (root.popupTransparent ? "transparent" : ComTheme.background))
            radius: ComTheme.radiusCombo
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
        // 根据 model 数量和 visibleItemCount 计算高度
        implicitHeight: Math.min(root.count, root.visibleItemCount) * root.itemHeight + 8
        padding: 4

        contentItem: ListView {
            id: listView
            clip: true
            implicitHeight: contentHeight
            model: root.popup.visible ? root.delegateModel : null
            currentIndex: root.highlightedIndex
            boundsBehavior: Flickable.StopAtBounds
            // 启用滚动条
            ScrollBar.vertical: ScrollBar {
                policy: root.count > root.visibleItemCount ? ScrollBar.AsNeeded : ScrollBar.AlwaysOff
            }
        }

        background: Rectangle {
            radius: ComTheme.radiusMedium
            color: root.popupTransparent ? "transparent" : ComTheme.background
            border.color: root.popupTransparent ? "transparent" : ComTheme.border
            border.width: root.popupTransparent ? 0 : 1

            // 阴影效果（仅在非透明时启用）
            layer.enabled: !root.popupTransparent
            layer.effect: Item {
                Rectangle {
                    anchors.fill: parent
                    // anchors.margins: -1
                    radius: ComTheme.radiusMedium /*+ 1*/
                    color: ComTheme.shadow
                    z: -1
                }
            }
        }
    }
}
