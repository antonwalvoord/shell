import QtQuick
import Quickshell

import qs.singletons

Text {
    id: root

    text: qsTr("")
    //text: qsTr("%1").arg(nodeDescription)

    font.family: "JetBrains Mono NF"
    font.bold: true
    font.pointSize: Constants.pointSize
    color: Constants.textColor
}
