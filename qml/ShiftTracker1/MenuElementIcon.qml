import QtQuick 1.1

MenuElement {
    id:menuElementIcon
    property alias icon:icon.source
    property alias text:text.text

    Column {
        anchors.centerIn:parent
        Image {
            id:icon
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id:text
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}
