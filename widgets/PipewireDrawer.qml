import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

import qs.singletons

PanelWindow {
    id: root
    anchors.top: true
    anchors.right: true
    property bool drawerOpen: false

    property ObjectModel nodesModel: Pipewire.nodes
    property list<PwNode> nodes: nodesModel.values

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
                model: root.nodes

                delegate: Text {
                    property string name: model.nickname
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
