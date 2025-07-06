//
// Bar.qml
//
// Config to manage the bar
//

import Quickshell
import Quickshell.Hyprland
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
                color: Constants.backgroundColor

                Row {
                    spacing: 60

                    anchors {
                        leftMargin: 15
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }

                    OsIcon {
                        id: osIcon
                    }

                    WorkspaceTracker {
                        id: workspace
                    }
                }

                ClockWidget {
                    id: clock

                    anchors {
                        centerIn: parent
                    }
                }

                // Row which houses mouse and laptop battery percentages
                Row {
                    id: batteryIcons

                    anchors {
                        rightMargin: 20
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }

                    spacing: 20

                    // radius: 10

                    MouseWidget {
                        id: mouse
                    }

                    BatteryWidget {
                        id: battery
                    }
                }
            }
        }
    }
}
