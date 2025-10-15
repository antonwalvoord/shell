import QtQuick
import Quickshell.Services.Pipewire

Text {

    property int volume: Math.round(Pipewire.defaultAudioSink?.audio.volume * 100)
    property bool muted: Pipewire.defaultAudioSink?.audio.muted
    property string nodeDescription: Pipewire.defaultAudioSink?.description

    function getVolumeIcon(muted, nodeDescription) {
        if (nodeDescription == "Anton’s AirPods") {
            if (muted) {
                return "󱡐";
            } else {
                return "󱡏";
            }
        } else {
            if (muted) {
                return "";
            } else {
                return "";
            }
        }
    }

    text: qsTr("%1 %2%").arg(getVolumeIcon(muted, nodeDescription)).arg(volume)
    //text: qsTr("%1").arg(nodeDescription)

    font.family: "JetBrains Mono NF"
    font.bold: true
    font.pointSize: Constants.pointSize
    color: Constants.textColor
}
