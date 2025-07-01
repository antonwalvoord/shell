//
// Bar.qml
//
// Config to manage the bar
//

import Quickshell

Scope {

    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            property int margin: 5
            screen: modelData
            color: "#BAF3DDBB"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: clock.implicitHeight + margin * 2

            OsIcon {
                id: osIcon

                anchors {
                    leftMargin: 10
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
        }
    }
}
