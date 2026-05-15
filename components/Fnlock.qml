import QtQuick
import QtQml
import Quickshell.Io

import qs.singletons

Text {
    id: root

    property string locked: ""
    property string unlocked: ""
    property bool isLocked: sysFile.text().trim() == "1"

    readonly property string fnPath: "/sys/devices/platform/lg-laptop/fn_lock"

    text: isLocked ? locked : unlocked
    //text: qsTr("%1").arg(sysFile.text())

    font.family: "JetBrains Mono NF"
    font.bold: true
    font.pointSize: Constants.pointSize
    color: Constants.textColor

    function toggleLock() {
        if (!shFnLock.running) {
            shFnLock.running = true;
        }
    }

    Process {
        id: shFnLock
        command: ["pkexec", "sh", "-c", "/usr/local/bin/fnlock"]

        onRunningChanged: {
            if (!running) {
                sysFile.reload();
            }
        }
    }

    FileView {
        id: sysFile
        path: root.fnPath
        blockLoading: true
        onTextChanged: {
            root.isLocked = sysFile.text().trim() == "1";
        }
    }
}
