//
// Bar.qml
//
// Config to manage the bar
//

import Quickshell
import QtQuick

Scope {

    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: clock.implicitHeight + Constants.margin * 2

            Rectangle {
                anchors.fill: parent

                radius: 10
                color: "#BAF3DDBB"

                OsIcon {
                    id: osIcon

                    anchors {
                        leftMargin: 15
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }
                }

                ClockWidget {
                    id: clock

                    anchors {
                        centerIn: parent
                    }
                }

                // TODO: Add a bar for these two to live in
                Rectangle {
                    id: batteryIcons

                    anchors {
                        rightMargin: 15
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }

                    implicitHeight: battery.implicitHeight
                    implicitWidth: battery.implicitWidth + mouse.implicitWidth + Constants.margin * 4

                    // radius: 10
                    color: "transparent"

                    BatteryWidget {
                        id: battery

                        anchors {
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseWidget {
                        id: mouse

                        anchors {
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
}
