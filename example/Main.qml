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
            ComLabel { text: "BasicButton 按钮"; bold: true }

            RowLayout {
                spacing: 12

                BasicButton {
                    text: "默认按钮"
                }

                BasicButton {
                    text: "圆角按钮"
                    radius: 18
                }

                BasicButton {
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

                ComComboBox {
                    model: ["选项 1", "选项 2", "选项 3", "选项 4"]
                }

                ComComboBox {
                    model: ["北京", "上海", "广州", "深圳"]
                    currentIndex: 1
                }

                ComComboBox {
                    model: ["禁用状态"]
                    enabled: false
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

            // ===== 卡片示例 =====
            ComLabel { text: "ComCard 卡片容器"; bold: true }

            RowLayout {
                spacing: 16

                ComCard {
                    width: 280
                    height: 180
                    title: "用户信息"
                    borderColor: ComTheme.border

                    contentItem: ColumnLayout {
                        spacing: 12
                        anchors.fill: parent

                        RowLayout {
                            spacing: 12
                            ComAvatar {
                                width: 48
                                height: 48
                                text: "张"
                                backgroundColor: ComTheme.primary
                            }
                            ColumnLayout {
                                spacing: 4
                                ComLabel { text: "张三"; bold: true }
                                ComLabel { text: "软件工程师"; secondary: true; size: "small" }
                            }
                        }

                        ComTextField {
                            Layout.fillWidth: true
                            placeholderText: "添加备注..."
                        }
                    }
                }

                ComCard {
                    width: 280
                    height: 180
                    title: "设置选项"
                    borderColor: ComTheme.border

                    contentItem: ColumnLayout {
                        spacing: 12
                        anchors.fill: parent

                        RowLayout {
                            Layout.fillWidth: true
                            ComLabel { text: "深色模式"; Layout.fillWidth: true }
                            ComSwitch {}
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            ComLabel { text: "消息通知"; Layout.fillWidth: true }
                            ComSwitch { checked: true }
                        }

                        ComCheckBox {
                            text: "记住我的选择"
                            checked: true
                        }
                    }
                }
            }

            // 底部间距
            Item { height: 20 }
        }
    }
}
