import QtQuick 1.1

Flipable {

    id:main
    width: 600
    height:600

    property bool flipped: false
    transform: Rotation {
        id: rotation
        origin.x: main.width/2
        origin.y: main.height/2
        axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
        angle: 0    // the default angle
    }
    states: State {
        name: "back"
        PropertyChanges { target: rotation; angle: 180 }
        when: flipped
    }
    transitions: Transition {
        NumberAnimation { target: rotation; property: "angle"; duration: 500 }
    }


    front:Root {
        id:root;

        TopMenu {id:raceMenuRow}
        RaceManager {id:raceManager}

        Popup {
            id:racePopupMenu
            name:"RacePopupMenu"
            delegate:RacePopupMenu {}
        }

        Popup {
            id:pitPopupMenu
            name:"PitPopupMenu"
            delegate:PitPopupMenu {}
        }

    }

    back:Rectangle {
        id:settingsPage
        anchors.fill:parent
        color: "blue"

        Row {
            id: settingsMenuRow
            height: 30
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            Rectangle {
                id: backRect
                width: parent.width/4
                color: "#ffffff"
                border.width: 1
                border.color: "black"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0

                Text {
                    id: backText
                    text:"Back"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: main.flipped=!main.flipped
                }
            }

        }


    }


}


