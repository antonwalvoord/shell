import QtQuick
import Quickshell.Services.UPower

Text {
    text: qsTr("󰁹 %1%").arg(Math.round(UPower.displayDevice.percentage * 100))
    font.family: "JetBrains Mono NF"
    font.bold: true
    font.pointSize: 13
    color: Constants.textColor
}
