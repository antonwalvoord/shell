import QtQuick
import Quickshell.Services.Mpris

import qs.singletons

Text {
    id: ticker
    property MprisPlayer player
    property real containerWidth
    property bool showing: false

    font.family: "JetBrains Mono NF"
    font.bold: true
    font.pointSize: Constants.pointSize
    color: Constants.textColor

    NumberAnimation {
        id: tickerAnim
        target: ticker
        property: "x"
        duration: 10000
        loops: Animation.Infinite
    }

    function checkScroll() {
        tickerAnim.stop();
        if (ticker.implicitWidth > ticker.containerWidth && showing) {
            ticker.x = ticker.containerWidth;
            tickerAnim.from = ticker.containerWidth;
            tickerAnim.to = -ticker.implicitWidth;
            tickerAnim.start();
        } else {
            ticker.x = (ticker.containerWidth - ticker.implicitWidth) / 2;
        }
    }

    onShowingChanged: checkScroll()
}
