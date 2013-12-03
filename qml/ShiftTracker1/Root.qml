import QtQuick 1.1


Rectangle {
    id:root
    width: 800
    height: 600
    anchors.fill:parent
    color:"#0e232e"

    signal rootMouseClicked
    signal openPopupMenuFor(variant target,string menuName,variant tag,variant receiver)
    signal closePopupMenu


    MouseArea {
        id:mouseroot
        anchors.fill:parent

        onClicked: {
            rootMouseClicked()
        }
    }
}


