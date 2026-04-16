import Quickshell
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import qs.singletons
import qs.widgets

PanelWindow {
    id: root
    anchors.top: true
    anchors.right: true
    property bool drawerOpen: false
    property bool scanning: false

    property ObjectModel devicesModel: Bluetooth.devices
    property list<BluetoothDevice> devices: devicesModel.values
    property BluetoothAdapter adapter: Bluetooth.defaultAdapter

    color: "transparent"

    implicitHeight: drawerOpen ? drawerCanvas.implicitHeight : 0
    implicitWidth: 300
    margins.right: 15

    screen: findMonitor()

    function findMonitor() {
        for (const s of Quickshell.screens) {
            if (Hyprland.monitorFor(s) === Hyprland.focusedMonitor) {
                return s;
            }
        }
    }

    Rectangle {
        id: drawerCanvas
        color: Constants.backgroundColor
        radius: Constants.radius * 3
        anchors.fill: parent
        implicitHeight: deviceColumn.implicitHeight

        Column {
            id: deviceColumn
            spacing: Constants.margin * 3
            topPadding: Constants.margin * 3
            bottomPadding: Constants.margin * 3
            anchors.fill: parent

            // Scan button
            StdButton {
                id: scanButton
                text: root.scanning ? "Stop Scan" : "Start Scan"
                implicitWidth: parent.implicitWidth
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: toggleScan()
                function toggleScan() {
                    root.scanning = !root.scanning;
                    root.adapter.discovering = root.scanning;
                }
            }

            // Device list
            Repeater {
                id: device
                model: root.devices

                delegate: RowLayout {
                    width: parent.width - Constants.margin * 6
                    Text {
                        id: deviceText
                        property string name: model.name
                        property string address: model.address
                        property bool show: device.compareMacAndName(address, name)

                        font.family: "JetBrains Mono NF"
                        font.bold: true
                        font.pointSize: Constants.pointSize
                        color: Constants.textColor
                        leftPadding: Constants.margin * 6

                        text: show ? name : ""
                        visible: show
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    StdButton {
                        text: connectionText()
                        radius: Constants.radius
                        onClicked: toggleConnect()
                        visible: deviceText.visible
                        function toggleConnect() {
                            model.connected = !model.connected;
                        }
                        function connectionText() {
                            switch (model.state) {
                                case BluetoothDeviceState.Disconnected:
                                    return "Connect";
                                case BluetoothDeviceState.Disconnecting:
                                    return "Disconnecting";
                                case BluetoothDeviceState.Connecting:
                                    return "Connecting";
                                case BluetoothDeviceState.Connected:
                                    return "Disconnect";
                                default:
                                    return "error";
                            }
                        }
                    }
                }

                function compareMacAndName(mac, name) {
                    var normalizedMac = mac.replace(/[:\-]/g, "");
                    var normalizedName = name.replace(/[:\-]/g, "");
                    return normalizedMac != normalizedName;
                }
            }
        }
    }

    MouseArea {
        id: mouseArea
        z: 1
        anchors.fill: parent
        hoverEnabled: root.drawerOpen
        propagateComposedEvents: true
        onClicked: mouse => {
            mouse.accepted = false;
        }
    }

    Connections {
        target: mouseArea
        function onExited() {
            root.drawerOpen = false;
        }
    }
}
