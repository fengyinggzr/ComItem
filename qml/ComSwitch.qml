import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComSwitch - 开关组件
Switch {
    id: root

    implicitWidth: 50
    implicitHeight: 26

    indicator: Rectangle {
        id: background
        width: root.implicitWidth
        height: root.implicitHeight
        radius: height / 2
        color: root.checked ? ComTheme.primary : ComTheme.border
        opacity: root.enabled ? 1.0 : 0.5

        Behavior on color {
            ColorAnimation { duration: ComTheme.animationDuration }
        }

        Rectangle {
            id: handle
            width: parent.height - 4
            height: width
            radius: width / 2
            color: ComTheme.background
            anchors.verticalCenter: parent.verticalCenter
            x: root.checked ? parent.width - width - 2 : 2

            Behavior on x {
                NumberAnimation { duration: ComTheme.animationDuration; easing.type: Easing.OutQuad }
            }

            // 阴影
            Rectangle {
                anchors.fill: parent
                anchors.margins: -1
                radius: parent.radius + 1
                color: "#20000000"
                z: -1
            }
        }
    }

    contentItem: Text {
        text: root.text
        font.pixelSize: ComTheme.fontSizeMedium
        color: root.enabled ? ComTheme.textPrimary : ComTheme.textDisabled
        verticalAlignment: Text.AlignVCenter
        leftPadding: root.indicator.width + ComTheme.spacingMedium
        visible: root.text !== ""
    }
}
