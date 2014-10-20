import QtQuick 1.1

MenuElement {
    id:menuElementIconOnly
    property alias icon:icon.source
    Image {
        id:icon
        anchors.centerIn: parent
    }
}
