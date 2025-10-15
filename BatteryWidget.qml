import QtQuick
import Quickshell.Services.UPower

Text {
    property int soc: Math.round(UPower.displayDevice.percentage * 100)
    property bool onBattery: UPower.onBattery

    function getBatteryIcon(soc, onBattery) {
        if (onBattery) {
            if (soc <= 10) {
                return "󰁺";
            } else if (soc <= 20) {
                return "󰁻";
            } else if (soc <= 30) {
                return "󰁼";
            } else if (soc <= 40) {
                return "󰁽";
            } else if (soc <= 50) {
                return "󰁾";
            } else if (soc <= 60) {
                return "󰁿";
            } else if (soc <= 70) {
                return "󰂀";
            } else if (soc <= 80) {
                return "󰂁";
            } else if (soc <= 90) {
                return "󰂂";
            } else {
                return "󰁹";
            }
        } else {
            if (soc <= 20) {
                return "󰂆";
            } else if (soc <= 40) {
                return "󰂈";
            } else if (soc <= 60) {
                return "󰂉";
            } else if (soc <= 80) {
                return "󰂊";
            } else {
                return "󰂅";
            }
        }
    }

    text: qsTr("%1 %2").arg(getBatteryIcon(soc, onBattery)).arg(soc)

    font.family: "JetBrains Mono NF"
    font.bold: true
    font.pointSize: Constants.pointSize
    color: Constants.textColor
}
