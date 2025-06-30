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

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: clock.implicitHeight + margin * 2

            ClockWidget {
                id: clock

                anchors {
                    rightMargin: 10
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
