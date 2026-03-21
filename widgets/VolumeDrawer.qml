import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Mpris

import qs.singletons

PanelWindow {
    id: root
    anchors.top: true
    anchors.right: true

    color: "transparent"

    implicitHeight: volume.drawerOpen ? 300 : 0
    implicitWidth: 300
    margins.right: 15

    property ObjectModel players: Mpris.players
    property list<QtObject> playerList: players.values
    property int currentPlayerNum: 0
    property MprisPlayer player: playerList[currentPlayerNum]

    Rectangle {
        color: Constants.backgroundColor
        radius: Constants.radius * 3
        anchors.fill: parent
        GridLayout {
            anchors.fill: parent
            columns: 1
            rowSpacing: 0
            columnSpacing: 10

            // Player Artwork
            Rectangle {
                id: mprisArtGrid
                Layout.columnSpan: 1
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.margins: Constants.margin * 6
                color: "transparent"
                Rectangle {
                    height: mprisArt.height + Constants.margin * 6
                    width: mprisArt.width + Constants.margin * 6
                    anchors.centerIn: parent
                    radius: Constants.radius
                    color: Constants.textColor
                    Rectangle {
                        anchors.centerIn: parent
                        width: mprisArt.paintedWidth + 2
                        height: mprisArt.paintedHeight + 2
                        color: "grey"
                        Image {
                            id: mprisArt
                            fillMode: Image.PreserveAspectFit
                            height: mprisArtGrid.height - Constants.margin * 2
                            width: mprisArtGrid.width - Constants.margin * 2
                            anchors.centerIn: parent
                            anchors.margins: Constants.margin * 2
                            source: root.player.trackArtUrl
                        }
                    }
                }
            }

            // Player title
            Rectangle {
                id: tickerContainer
                Layout.columnSpan: 1
                Layout.fillWidth: true
                Layout.leftMargin: Constants.margin * 6
                Layout.rightMargin: Constants.margin * 6
                implicitHeight: ticker.implicitHeight
                color: "transparent"
                clip: true

                Text {
                    id: ticker
                    text: root.player.trackTitle
                    font.family: "JetBrains Mono NF"
                    font.bold: true
                    font.pointSize: Constants.pointSize
                    color: Constants.textColor

                    NumberAnimation {
                        id: tickerAnim
                        target: ticker
                        property: "x"
                        from: tickerContainer.width
                        to: -ticker.implicitWidth
                        duration: 10000
                        loops: Animation.Infinite
                    }

                    function checkScroll() {
                        tickerAnim.stop();
                        if (ticker.implicitWidth > tickerContainer.width) {
                            tickerAnim.start();
                        } else {
                            ticker.x = (tickerContainer.width - ticker.implicitWidth) / 2;
                        }
                    }
                }

                Connections {
                    target: root.player
                    function onPostTrackChanged() {
                        ticker.checkScroll();
                    }
                }

                Component.onCompleted: ticker.checkScroll()
            }

            // Progress through the playback
            ProgressBar {
                id: progressBar
                Layout.columnSpan: 1
                Layout.fillWidth: true

                property real playerPosition: root.player.position
                property real length: root.player.length
                property real progress: playerPosition / length

                Layout.margins: Constants.margin * 6
                value: progress

                contentItem: Item {
                    Rectangle {
                        width: progressBar.visualPosition * parent.width
                        height: parent.height
                        radius: Constants.radius
                        color: Constants.textColor
                    }
                }

                background: Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 12
                    radius: Constants.radius
                }
            }

            Rectangle {
                Layout.columnSpan: 1
                Layout.fillWidth: true
                color: "transparent"
                height: 60

                Text {
                    anchors.centerIn: parent
                    text: "  "
                    font.family: "JetBrains Mono NF"
                    font.bold: true
                    font.pointSize: Constants.pointSize * 2
                    color: Constants.textColor
                }
            }
        }
    }

    Timer {
        id: playbackTimer
        // only emit the signal when the position is actually changing.
        running: root.player.playbackState == MprisPlaybackState.Playing
        // Make sure the position updates at least once per second.
        interval: 1000
        repeat: true
        // emit the positionChanged signal every second.
        onTriggered: root.player.positionChanged()
    }
}
