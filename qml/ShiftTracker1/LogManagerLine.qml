import QtQuick 1.1

Rectangle {
    id:line
    anchors.fill:children

    opacity:0.9
    property int opn
    property alias time:time.counter
    property alias team:team.text
    property alias from_kart:from_kart.text
    property alias to_kart:to_kart.text

    Row {
        width:200
        height:50
        spacing: 4

        Image {
            source:"img/l_time.png"
            RaceTime {
                id:time
                anchors.centerIn:parent
            }
        }
        Image {
            source:"img/l_team.png"
            Text {
                id:team
                anchors.centerIn:parent
            }
        }

        Rectangle {color:"transparent";width:20;height:20}
        Image {
            source:"img/l_k1.png"
            Text {
                id:from_kart
                anchors.centerIn:parent
            }
        }
        Image {
            source:"img/l_right.png"
            //anchors.verticalCenter: parent.verticalCenter
        }
        Image {
            source:"img/l_k4.png"
            Text {
                id:to_kart
                anchors.centerIn:parent
            }

        }
    }
}
