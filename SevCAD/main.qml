import QtCanvas3D 1.0
import QtQuick 2.11
import QtQuick.Layouts 1.1
import Qt3D.Input 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.4

import "glcode.js" as GLCode

Window {
    id: window
    title: qsTr("SevCAD")
    width: 1280
    height: 720
    visible: true
    color: "#262626"


        Rectangle
        {
            x:0
            y:0
            width : 1280
            height: 100
            color: "#262626"

            CustomBorder
            {
                commonBorder: false
                lBorderwidth: 0
                rBorderwidth: 0
                tBorderwidth: 0
                bBorderwidth: 1
                borderColor: "red"
            }



            Button {
                id: button
                x: 10
                y: 10
                width: 100

                contentItem: Text {
                    id: buttonText
                    text: qsTr("Button")
                    horizontalAlignment: Text.AlignHCenter
                    font: button.font
                    color:"#262626"
                    anchors.centerIn : parent
                }
                onClicked: {

                }

                background: Rectangle {
                    id: buttonRect
                    color: "#ff0000"
                    width: parent.width
                    height: parent.height
                    border.color: "#ff0000"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        buttonRect.color = "#262626";
                        buttonText.color = "#ff0000";
                    }
                    onExited: {
                        buttonRect.color = "#ff0000";
                        buttonText.color = "#262626";
                    }
                    onClicked: {
                        menu.visible = true;
                    }
                }
            }


            Menu {
                id: menu
                visible: false
                x: button.x
                y: button.y + button.height
                Action {
                    text: qsTr("Tool Bar");
                }
                Action { text: qsTr("Side Bar"); checkable: true; checked: true }
                Action { text: qsTr("Status Bar"); checkable: true; checked: true }

                MenuSeparator {
                    contentItem: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 1
                        color: "#ff0000"
                    }
                }

                Menu {
                    title: qsTr("Advanced")
                    // ...
                }

                topPadding: 2
                bottomPadding: 2

                delegate: MenuItem {
                    id: menuItem
                    implicitWidth: 200
                    implicitHeight: 40

                    arrow: Canvas {
                        x: parent.width - width
                        implicitWidth: 40
                        implicitHeight: 40
                        visible: menuItem.subMenu
                        onPaint: {
                            var ctx = getContext("2d")
                            ctx.fillStyle = menuItem.highlighted ? "#262626" : "#ff0000"
                            ctx.moveTo(15, 15)
                            ctx.lineTo(width - 15, height / 2)
                            ctx.lineTo(15, height - 15)
                            ctx.closePath()
                            ctx.fill()
                        }
                    }

                    indicator: Item {
                        implicitWidth: 40
                        implicitHeight: 40
                        Rectangle {
                            width: 26
                            height: 26
                            anchors.centerIn: parent
                            visible: menuItem.checkable
                            color:"#262626"
                            border.color: "#ff0000"
                            radius: 3
                            Rectangle {
                                width: 14
                                height: 14
                                anchors.centerIn: parent
                                visible: menuItem.checked
                                color: "#ff0000"
                                radius: 2
                            }
                        }
                    }

                    contentItem: Text {
                        leftPadding: menuItem.indicator.width
                        rightPadding: menuItem.arrow.width
                        text: menuItem.text
                        font: menuItem.font
                        opacity: enabled ? 1.0 : 0.3
                        color: menuItem.highlighted ? "#262626" : "#ff0000"
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }

                    background: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        color: menuItem.highlighted ? "#ff0000" : "transparent"
                    }
                }

                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 40
                    color: "#262626"
                    border.color: "#ff0000"
                    radius: 2
                }
            }




        }

        Rectangle
        {
            x:0
            y:110
            width : 300
            height: 610
            color: "#262626"

            CustomBorder
            {
                commonBorder: false
                lBorderwidth: 0
                rBorderwidth: 1
                tBorderwidth: 1
                bBorderwidth: 0
                borderColor: "red"
            }
        }

        Rectangle
        {
            x:310
            y:110
            width : 970
            height: 610
            color: "#262626"


            CustomBorder
            {
                commonBorder: false
                lBorderwidth: 1
                rBorderwidth: 0
                tBorderwidth: 1
                bBorderwidth: 0
                borderColor: "red"
            }

            Text {
                id: fpsCounter
                text: canvas3d.fps
                font.family: "Helvetica"
                font.pointSize: 24
                color: "red"
                anchors.top: canvas3d.top
                anchors.right: canvas3d.right
                z:999
            }

            Canvas3D {
                id: canvas3d
                width: parent.width
                height: parent.height
                focus: true

                onInitializeGL: {
                    GLCode.initializeGL(canvas3d , eventSource);
                }

                onPaintGL: {
                    GLCode.paintGL(canvas3d);
                }

                onResizeGL: {
                    GLCode.resizeGL(canvas3d);
                }

                ControlEventSource {
                    anchors.fill: parent
                    focus: true
                    id: eventSource
                }
            }
        }

}
