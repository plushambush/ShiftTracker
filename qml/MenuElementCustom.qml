import QtQuick 1.1

Rectangle {
    id:menuElementCustom
    width:childrenRect.width+1
    height:childrenRect.height+1
    color:"transparent"
    radius:10

    property color hovercolor:"blue"
    property string eventid
    property Item delegate

    signal menuItemSelected(string eventid)


    states: [
        State {
            name:"Focus"
            PropertyChanges {
                target: menuElementCustom
                color:hovercolor
            }
        }

    ]
    MouseArea {
        anchors.fill:parent
        hoverEnabled: true
        onEntered: {
            parent.state="Focus"

        }
        onExited: {
            parent.state=""

        }
        onClicked: {
            menuItemSelected(eventid)
        }


    }
}
