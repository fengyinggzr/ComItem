import QtQuick

// ComSwitch - 开关组件
Item {
    id: root

    property bool checked: false
    property color checkedColor: "#2ecc71"
    property color uncheckedColor: "#cccccc"
    property color handleColor: "#ffffff"
    property bool enabled: true

    signal toggled(bool checked)

    width: 50
    height: 26
    opacity: enabled ? 1.0 : 0.5

    Rectangle {
        id: background
        anchors.fill: parent
        radius: height / 2
        color: root.checked ? root.checkedColor : root.uncheckedColor

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

    Rectangle {
        id: handle
        width: parent.height - 4
        height: width
        radius: width / 2
        color: root.handleColor
        anchors.verticalCenter: parent.verticalCenter
        x: root.checked ? parent.width - width - 2 : 2

        Behavior on x {
            NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
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

    MouseArea {
        anchors.fill: parent
        enabled: root.enabled
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: {
            root.checked = !root.checked
            root.toggled(root.checked)
        }
    }
}
