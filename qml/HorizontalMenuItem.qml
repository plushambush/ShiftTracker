import QtQuick 1.1

Rectangle {
    width: parent.width/parent.children.length
    anchors.top:parent.top
    anchors.bottom: parent.bottom
    border.width: 3
    border.color:"#0e232e"
    opacity:0.95
    property alias text:text.text
    signal horizontalMenuItemClicked



    Text {
        anchors.centerIn: parent
        id:text
        font.family: "Impact"
        font.pointSize: 12
        color:"#0e232e"
        states:[
            State {
                name:"Focused"
                when: ma.containsMouse()
                PropertyChanges {
                    target:text
                    color:"#ff6600"
                }
            }

        ]

    }

    MouseArea {
        id:ma
        anchors.fill:parent
        hoverEnabled: true
        onClicked:horizontalMenuItemClicked()
        onEntered: text.state="Focused"
        onExited: text.state=""
    }





}
