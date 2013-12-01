import QtQuick 1.1


Rectangle {
    id:root
    width: 800
    height: 600

    signal rootMouseClicked
    signal openPopupMenuFor(string menuName,variant target)
    signal closePopupMenu


    MouseArea {
        id:mouseroot
        anchors.fill:parent

        onClicked: {
            rootMouseClicked()
        }
    }
}


