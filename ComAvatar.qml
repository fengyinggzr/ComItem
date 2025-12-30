import QtQuick

// ComAvatar - 头像组件
Item {
    id: root

    property string source: ""
    property string text: ""
    property color backgroundColor: "#3498db"
    property color textColor: "#ffffff"
    property int radius: width / 2  // 默认圆形
    property int borderWidth: 0
    property color borderColor: "#ffffff"

    width: 48
    height: 48

    Rectangle {
        id: container
        anchors.fill: parent
        radius: root.radius
        color: root.backgroundColor
        border.width: root.borderWidth
        border.color: root.borderColor
        clip: true

        // 文字头像
        Text {
            id: avatarText
            anchors.centerIn: parent
            text: root.text.length > 0 ? root.text.charAt(0).toUpperCase() : ""
            font.pixelSize: parent.height * 0.4
            font.bold: true
            color: root.textColor
            visible: root.source.length === 0
        }

        // 图片头像
        Image {
            id: avatarImage
            anchors.fill: parent
            source: root.source
            fillMode: Image.PreserveAspectCrop
            visible: root.source.length > 0
            layer.enabled: true
            layer.effect: Item {
                Rectangle {
                    anchors.fill: parent
                    radius: root.radius
                }
            }
        }
    }
}
