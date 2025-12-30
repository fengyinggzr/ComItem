import QtQuick

// ComBadge - 徽章组件
Item {
    id: root

    property alias text: badgeText.text
    property color backgroundColor: "#e74c3c"
    property color textColor: "#ffffff"
    property int radius: 10
    property int padding: 6
    property int minWidth: 20

    implicitWidth: Math.max(minWidth, badgeText.width + padding * 2)
    implicitHeight: Math.max(minWidth, badgeText.height + padding)

    Rectangle {
        anchors.fill: parent
        radius: root.radius
        color: root.backgroundColor

        Text {
            id: badgeText
            anchors.centerIn: parent
            font.pixelSize: 12
            font.bold: true
            color: root.textColor
            text: "0"
        }
    }
}
