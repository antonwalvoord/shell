import Quickshell
import Quickshell.Bluetooth
import QtQuick

import qs.singletons

PanelWindow {
    id: root
    anchors.top: true
    anchors.right: true
    property bool drawerOpen: false

    property ObjectModel devicesModel: Bluetooth.devices
    property list<BluetoothDevice> devices: devicesModel.values

    color: "transparent"

    implicitHeight: drawerOpen ? drawerCanvas.implicitHeight : 0
    implicitWidth: 300
    margins.right: 15

    Rectangle {
        id: drawerCanvas
        color: Constants.backgroundColor
        radius: Constants.radius * 3
        anchors.fill: parent
        implicitHeight: deviceColumn.implicitHeight

        Column {
            id: deviceColumn
            spacing: 10
            Repeater {
                id: device
                model: root.devices

                delegate: Text {
                    property string name: model.name
                    property string address: model.address
                    property bool show: device.compareMacAndName(address, name)

                    text: show ? name : ""
                }

                function compareMacAndName(mac, name) {
                    var normalizedMac = mac.replace(/[:\-]/g, "");
                    var normalizedName = name.replace(/[:\-]/g, "");
                    return normalizedMac != normalizedName;
                }
            }
        }
    }
}
