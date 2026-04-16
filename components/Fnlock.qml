import QtQuick
import Quickshell

import qs.singletons

Text {
    id: root

    property string locked: ""
    property string unlocked: ""

    readonly property string fnPath: "/sys/devices/platform/lg-laptop/fn_lock"

    text: locked
    //text: qsTr("%1").arg(nodeDescription)

    font.family: "JetBrains Mono NF"
    font.bold: true
    font.pointSize: Constants.pointSize
    color: Constants.textColor
}
