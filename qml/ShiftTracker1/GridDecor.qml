import QtQuick 1.1

Rectangle {
    id:decor
    color:"transparent"
    border.color: "#364e59"
    border.width: 3
    radius:5
    property alias name:text.text
    Text {
        id:text
        font.family: "Impact"
        font.pixelSize: 26
        opacity: 0.3
        anchors.bottom: parent.top
    }
}
