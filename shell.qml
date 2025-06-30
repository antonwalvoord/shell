import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 25
  //implicitWidth: 30

  Text {
    id: clock

    // center the bar in its parent component (the window)
    anchors.centerIn: parent

    Process {
      id: dateProc

      command: ["date"]
      running: true
      stdout: StdioCollector {
        onStreamFinished: clock.text = this.text
      }
    }

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: dateProc.running = true
    }
  }
}
