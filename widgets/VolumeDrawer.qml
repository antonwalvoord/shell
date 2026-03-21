import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Quickshell.Services.Mpris

import qs.singletons

PanelWindow {
    id: root
    anchors.top: true
    anchors.right: true

    color: "transparent"

    implicitHeight: volume.drawerOpen ? 300 : 0
    implicitWidth: 300
    // margins.right: batteryIcons.implicitWidth - volume.implicitWidth

    property ObjectModel players: Mpris.players
    property list<QtObject> playerList: players.values
    property int currentPlayer: 0

    Rectangle {
        color: Constants.backgroundColor
        radius: Constants.radius * 3
        anchors.fill: parent
        GridLayout {
            anchors.fill: parent
            columns: 3
            rowSpacing: 10
            columnSpacing: 10

            Rectangle {
                Layout.columnSpan: 3
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.margins: Constants.margin * 6
                color: "transparent"
                Rectangle {
                    height: parent.height
                    width: height
                    anchors.centerIn: parent
                    radius: Constants.radius
                    color: "transparent"
                    border.color: Constants.textColor
                    border.width: Constants.margin * 2
                    Image {
                        fillMode: Image.PreserveAspectCrop
                        anchors.fill: parent
                        anchors.margins: Constants.margin * 2
                        source: root.playerList[root.currentPlayer].trackArtUrl
                    }
                }
            }

            Row {
                Layout.columnSpan: 2
                Layout.fillWidth: true
                height: 50
            }
        }
    }
}
