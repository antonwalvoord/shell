import QtQuick

import qs.singletons

Text {
    text: Time.time
    font.family: "JetBrains Mono NF"
    font.bold: true
    font.pointSize: Constants.pointSize
    color: Constants.textColor
}
