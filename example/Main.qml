import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ComItem

Window {
    width: 900
    height: 700
    visible: true
    title: qsTr("ComItem Example - 蓝紫色主题组件库")
    color: "#f8fafc"

    ScrollView {
        anchors.fill: parent
        anchors.margins: 20

        ColumnLayout {
            width: parent.width
            spacing: 24

            // 标题
            ComLabel {
                text: "ComItem 组件库演示"
                size: "large"
                bold: true
            }

            ComLabel {
                text: "统一蓝紫色主题风格的 QML 组件集合"
                secondary: true
            }

            // 分隔线
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: ComTheme.border
            }

            // ===== 按钮组 =====
            ComLabel { text: "ComButton 按钮"; bold: true }

            RowLayout {
                spacing: 12

                ComButton {
                    text: "默认按钮"
                }

                ComButton {
                    text: "圆角按钮"
                    radius: 18
                }

                ComButton {
                    text: "禁用状态"
                    enabled: false
                }
            }

            // ===== 输入框组 =====
            ComLabel { text: "ComTextField 输入框"; bold: true }

            RowLayout {
                spacing: 12

                ComTextField {
                    placeholderText: "请输入内容..."
                }

                ComTextField {
                    placeholderText: "错误状态"
                    error: true
                }

                ComTextField {
                    placeholderText: "禁用状态"
                    enabled: false
                }
            }

            // ===== 下划线输入框组 =====
            ComLabel { text: "ComLineTextField 下划线输入框"; bold: true }

            RowLayout {
                spacing: 12

                ComLineTextField {
                    placeholderText: "请输入内容..."
                }

                ComLineTextField {
                    placeholderText: "错误状态"
                    error: true
                }

                ComLineTextField {
                    placeholderText: "禁用状态"
                    enabled: false
                }
            }

            // ===== 复选框组 =====
            ComLabel { text: "ComCheckBox 复选框"; bold: true }

            RowLayout {
                spacing: 24

                ComCheckBox {
                    text: "选项 A"
                }

                ComCheckBox {
                    text: "选项 B（已选中）"
                    checked: true
                }

                ComCheckBox {
                    text: "禁用状态"
                    enabled: false
                }
            }

            // ===== 开关组 =====
            ComLabel { text: "ComSwitch 开关"; bold: true }

            RowLayout {
                spacing: 24

                RowLayout {
                    spacing: 8
                    ComSwitch {
                        id: switch1
                    }
                    ComLabel {
                        text: switch1.checked ? "开启" : "关闭"
                        secondary: true
                    }
                }

                RowLayout {
                    spacing: 8
                    ComSwitch {
                        checked: true
                    }
                    ComLabel {
                        text: "默认开启"
                        secondary: true
                    }
                }

                RowLayout {
                    spacing: 8
                    ComSwitch {
                        enabled: false
                    }
                    ComLabel {
                        text: "禁用"
                        secondary: true
                    }
                }
            }

            // ===== 下拉框组 =====
            ComLabel { text: "ComComboBox 下拉框"; bold: true }

            RowLayout {
                spacing: 12

                ColumnLayout {
                    spacing: 4
                    ComComboBox {
                        model: ["选项 1", "选项 2", "选项 3", "选项 4", "选项 5", "选项 6"]
                    }
                    ComLabel { text: "默认3行"; secondary: true; size: "small" }
                }

                ColumnLayout {
                    spacing: 4
                    ComComboBox {
                        model: ["北京", "上海", "广州", "深圳", "杭州", "南京", "武汉"]
                        currentIndex: 1
                        visibleItemCount: 5
                    }
                    ComLabel { text: "显示5行"; secondary: true; size: "small" }
                }

                ColumnLayout {
                    spacing: 4
                    ComComboBox {
                        model: ["禁用状态"]
                        enabled: false
                    }
                    ComLabel { text: "禁用状态"; secondary: true; size: "small" }
                }
            }

            // ===== 标签组 =====
            ComLabel { text: "ComLabel 标签"; bold: true }

            RowLayout {
                spacing: 24

                ComLabel {
                    text: "小号文字"
                    size: "small"
                }

                ComLabel {
                    text: "中号文字（默认）"
                    size: "medium"
                }

                ComLabel {
                    text: "大号文字"
                    size: "large"
                }

                ComLabel {
                    text: "次要文字"
                    secondary: true
                }

                ComLabel {
                    text: "加粗文字"
                    bold: true
                }
            }

            // ===== 自定义绘图组 =====
            ComLabel { text: "ComCanvas 自定义绘图"; bold: true }

            RowLayout {
                spacing: 16

                ComCanvas {
                    width: 80
                    height: 80
                    shape: "rectangle"
                }

                ComCanvas {
                    width: 80
                    height: 80
                    shape: "circle"
                }

                ComCanvas {
                    width: 80
                    height: 80
                    shape: "triangle"
                }

                ComCanvas {
                    width: 80
                    height: 80
                    shape: "star"
                }

                ComCanvas {
                    width: 120
                    height: 80
                    shape: "wave"
                    filled: false

                    // 波浪动画
                    NumberAnimation on progress {
                        from: 0
                        to: 1
                        duration: 2000
                        loops: Animation.Infinite
                    }
                }

                ComCanvas {
                    width: 140
                    height: 80
                    shape: "chart"
                }
            }

            // 底部间距
            Item { height: 20 }
        }
    }
}
