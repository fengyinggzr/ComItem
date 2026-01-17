import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComQmlProgressBar - 基于 QML 原生 ProgressBar 的进度条组件
ProgressBar {
    id: root

    implicitWidth: 200
    implicitHeight: 8

    // 自定义属性
    property bool showText: false
    property int radius: ComTheme.radiusSmall

    background: Rectangle {
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight
        radius: root.radius
        color: root.enabled ? ComTheme.border : ComTheme.backgroundDisabled

        Behavior on color {
            ColorAnimation { duration: ComTheme.animationDuration }
        }
    }

    contentItem: Item {
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight
        clip: true  // 防止不确定进度条动画溢出

        // 确定进度条
        Rectangle {
            id: progressRect
            visible: !root.indeterminate
            width: root.visualPosition * parent.width
            height: parent.height
            radius: root.radius
            color: root.enabled ? ComTheme.primary : ComTheme.textDisabled

            //问题在于 Behavior on width 与外部的 NumberAnimation on value 冲突。
            //当 value 持续快速变化时，Behavior 不断尝试重新启动平滑动画，导致宽度变化非常缓慢或几乎不动。
            // Behavior on width {
            //     NumberAnimation { duration: ComTheme.animationDuration }
            // }

            Behavior on color {
                ColorAnimation { duration: ComTheme.animationDuration }
            }

            // 渐变效果
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: ComTheme.primary }
                    GradientStop { position: 1.0; color: ComTheme.primaryHover }
                }
                visible: root.enabled
            }
        }

        // 不确定进度条（动画）
        Rectangle {
            id: indeterminateRect
            visible: root.indeterminate
            width: parent.width * 0.3
            height: parent.height
            radius: root.radius
            color: ComTheme.primary

            // 渐变效果
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: ComTheme.primaryLight }
                    GradientStop { position: 0.5; color: ComTheme.primary }
                    GradientStop { position: 1.0; color: ComTheme.primaryLight }
                }
            }

            SequentialAnimation on x {
                running: root.indeterminate && root.visible
                loops: Animation.Infinite

                NumberAnimation {
                    from: -indeterminateRect.width
                    to: root.availableWidth
                    duration: 1200
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // 进度文本
        Text {
            visible: root.showText && !root.indeterminate
            anchors.centerIn: parent
            text: Math.round(root.value * 100) + "%"
            font.pixelSize: ComTheme.fontSizeSmall
            color: root.enabled ? ComTheme.textPrimary : ComTheme.textDisabled
        }
    }
}
