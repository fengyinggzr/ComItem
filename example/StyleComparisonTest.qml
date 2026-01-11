import QtQuick
import QtQuick.Window
import ComItem

Window {
    width: 800
    height: 600
    visible: true
    title: "ComItem 风格方案对比测试"

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "方案对比测试 - 请在 Qt Design Studio 预览中查看"
            font.pixelSize: 18
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // 原始版本（使用单例 - 预览可能失败）
        Row {
            spacing: 10
            Text {
                text: "原始单例："
                width: 150
                anchors.verticalCenter: parent.verticalCenter
            }
            ComButton {
                text: "Singleton 版本"
            }
        }

        // 方案一：Attached Properties
        Row {
            spacing: 10
            Text {
                text: "附加属性："
                width: 150
                anchors.verticalCenter: parent.verticalCenter
            }
            ComButton2_AttachedStyle {
                text: "Attached 版本"
            }
        }

        // 方案二：内联样式
        Row {
            spacing: 10
            Text {
                text: "内联样式："
                width: 150
                anchors.verticalCenter: parent.verticalCenter
            }
            ComButton3_InlineStyle {
                text: "Inline 版本"
            }
        }

        // 方案三：实例化 QtObject
        Row {
            spacing: 10
            Text {
                text: "实例对象："
                width: 150
                anchors.verticalCenter: parent.verticalCenter
            }
            ComButton4_InstanceStyle {
                text: "Instance 版本"
            }
        }

        Rectangle {
            width: 600
            height: 1
            color: "#cccccc"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "✅ 在预览中都能正确显示蓝紫色的方案即为可用方案"
            font.pixelSize: 14
            color: "#10b981"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
