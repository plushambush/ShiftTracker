import QtQuick 1.1


Rectangle {
    id:root
    anchors.fill:parent
    color:"#0e232e"

    signal rootMouseClicked
    signal openPopupMenuFor(variant target,string menuName,variant tag,variant receiver)
    signal closePopupMenu

    /*Text {
        text:"FCVP"
        font.family: "Impact"
        font.pixelSize: 300
        anchors.centerIn:parent
        color:"white"
        opacity: 0.02
    }*/

    MouseArea {
        id:mouseroot
        anchors.fill:parent

        onClicked: {
            rootMouseClicked()
        }
    }
}


