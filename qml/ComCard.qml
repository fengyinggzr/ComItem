import QtQuick

// ComCard - 卡片容器组件
Item {
    id: root

    property alias title: titleText.text
    property alias contentItem: contentArea.children
    property color backgroundColor: "#ffffff"
    property color borderColor: "#e0e0e0"
    property color titleColor: "#333333"
    property int radius: 8
    property int borderWidth: 1
    property int padding: 16

    Rectangle {
        id: card
        anchors.fill: parent
        color: root.backgroundColor
        radius: root.radius
        border.color: root.borderColor
        border.width: root.borderWidth

        // 阴影效果
        layer.enabled: true
        layer.effect: Item {
            Rectangle {
                anchors.fill: parent
                anchors.margins: -2
                color: "transparent"
                radius: root.radius + 2
                border.color: "#20000000"
                border.width: 4
                z: -1
            }
        }

        Column {
            anchors.fill: parent
            anchors.margins: root.padding
            spacing: 12

            // 标题
            Text {
                id: titleText
                width: parent.width
                font.pixelSize: 16
                font.bold: true
                color: root.titleColor
                visible: text.length > 0
            }

            // 分隔线
            Rectangle {
                width: parent.width
                height: 1
                color: root.borderColor
                visible: titleText.visible
            }

            // 内容区域
            Item {
                id: contentArea
                width: parent.width
                height: parent.height - titleText.height - (titleText.visible ? 25 : 0)
            }
        }
    }
}
