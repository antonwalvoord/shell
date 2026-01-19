//
// Bar.qml
//
// Config to manage the bar
//

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Scope {

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

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
                anchors {
                    leftMargin: 15
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }

                radius: Constants.radius
                color: Constants.backgroundColor

                implicitWidth: leftbar.width + Constants.margin * 4
                implicitHeight: clock.implicitHeight + Constants.margin * 2

                Row {
                    id: leftbar

                    spacing: 60

                    anchors {
                        leftMargin: Constants.margin * 2
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
            }

            Rectangle {
                anchors {
                    centerIn: parent
                }

                radius: Constants.radius
                color: Constants.backgroundColor

                implicitWidth: clock.width + Constants.margin * 4
                implicitHeight: clock.implicitHeight + Constants.margin * 2

                ClockWidget {
                    id: clock

                    anchors {
                        centerIn: parent
                    }
                }
            }

            Rectangle {
                anchors {
                    rightMargin: 20
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }

                radius: Constants.radius
                color: Constants.backgroundColor

                implicitWidth: batteryIcons.width + Constants.margin * 4
                implicitHeight: batteryIcons.implicitHeight + Constants.margin * 2

                // Row which houses mouse and laptop battery percentages
                Row {
                    id: batteryIcons

                    anchors {
                        rightMargin: Constants.margin * 2
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }

                    spacing: 20

                    // radius: 10

                    VolumeIcon {
                        id: volume
                    }

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
