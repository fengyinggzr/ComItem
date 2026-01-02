import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ComItem

Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("ComItem Example")

    ScrollView {
        anchors.fill: parent
        anchors.margins: 20

        ColumnLayout {
            width: parent.width
            spacing: 20

            // 标题
            Text {
                text: "ComItem 组件示例"
                font.pixelSize: 24
                font.bold: true
            }

            // ComSwitch 示例
            GroupBox {
                title: "ComSwitch"
                Layout.fillWidth: true

                RowLayout {
                    spacing: 20

                    ComSwitch {
                        id: switch1
                        // text: "开关 1"
                    }

                    ComSwitch {
                        id: switch2
                        // text: "开关 2"
                        checked: true
                    }

                    Text {
                        text: "开关1: " + (switch1.checked ? "开" : "关") +
                              " | 开关2: " + (switch2.checked ? "开" : "关")
                    }
                }
            }

            // ComCard 示例
            GroupBox {
                title: "ComCard"
                Layout.fillWidth: true

                RowLayout {
                    spacing: 20

                    ComCard {
                        width: 200
                        height: 150
                    }

                    ComCard {
                        width: 200
                        height: 150
                    }
                }
            }

            // ComAvatar 示例
            GroupBox {
                title: "ComAvatar"
                Layout.fillWidth: true

                RowLayout {
                    spacing: 20

                    ComAvatar {
                        width: 64
                        height: 64
                    }

                    ComAvatar {
                        width: 48
                        height: 48
                    }

                    ComAvatar {
                        width: 32
                        height: 32
                    }
                }
            }

            // ComBadge 示例
            GroupBox {
                title: "ComBadge"
                Layout.fillWidth: true

                RowLayout {
                    spacing: 20

                    ComProgressBar {

                        value: 50
                    }

                }
            }

            // 占位
            Item {
                Layout.fillHeight: true
            }
        }
    }
}
