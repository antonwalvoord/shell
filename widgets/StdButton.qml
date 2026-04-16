import QtQuick

import qs.singletons

Rectangle {
    id: root

    property string text
    signal clicked

    radius: Constants.radius * 3
    implicitHeight: buttonText.implicitHeight
    implicitWidth: buttonText.implicitWidth + Constants.margin * 3
    color: Constants.textColor

    Text {
        id: buttonText
        font.family: "JetBrains Mono NF"
        font.bold: true
        font.pointSize: Constants.pointSize
        color: Constants.backgroundColor
        anchors.horizontalCenter: parent.horizontalCenter

        text: root.text
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
