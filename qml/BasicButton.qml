import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

Button {
    id: root
    width: 150
    height: 40

    text: qsTr("text")
    font.pixelSize: 16

    property alias color: contentText.color
    property alias radius: backRect.radius

    contentItem: Text {
        id: contentText
        text: root.text
        font: root.font
        // color: root.pressed ? "#FFFFFF" : "black"
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        id: backRect
        implicitWidth: root.width
        implicitHeight: root.height
        radius: 4
        color: enabled ? ((root.checked | root.pressed) ? "#6FC2F0" : "#0A9CEE") : "#D0D4DB"
    }
}
