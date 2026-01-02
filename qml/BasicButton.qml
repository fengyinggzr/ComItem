import QtQuick
import QtQuick.Controls.Basic

Button {
    id: root
    width: 150
    height: 40

    property alias radius: backRect.radius

    background: Rectangle {
        id: backRect
        implicitWidth: root.width
        implicitHeight: root.height
        radius: 4
        color: enabled ? ((root.checked | root.pressed) ? "#6FC2F0" : "#0A9CEE") : "#D0D4DB"
        
    }
}
