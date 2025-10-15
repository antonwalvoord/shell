import QtQuick
import Quickshell.Services.UPower

Text {
    property int mouseEnum: 5
    property bool mouseDetected: UPower.devices.values.find(item => item.type == mouseEnum) != undefined
    property double mousePercentage: UPower.devices.values.find(item => item.type == mouseEnum).percentage

    text: mouseDetected ? qsTr("󰦋 %1%").arg(Math.round(mousePercentage * 100)) : ""
    font.family: "JetBrains Mono NF"
    font.bold: true
    font.pointSize: Constants.pointSize
    color: Constants.textColor
}
