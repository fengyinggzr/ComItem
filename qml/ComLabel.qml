import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// ComLabel - 标签组件
Label {
    id: root

    property string size: "medium"  // "small", "medium", "large"
    property bool bold: false
    property bool secondary: false

    color: root.enabled
        ? (root.secondary ? ComTheme.textSecondary : ComTheme.textPrimary)
        : ComTheme.textDisabled

    font.pixelSize: {
        switch (size) {
            case "small": return ComTheme.fontSizeSmall
            case "large": return ComTheme.fontSizeLarge
            default: return ComTheme.fontSizeMedium
        }
    }

    font.bold: root.bold
    elide: Text.ElideRight
}
