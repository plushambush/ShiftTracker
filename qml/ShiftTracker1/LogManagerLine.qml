import QtQuick 1.1
import "Util.js" 1.0 as Util

Rectangle {
    id:line
    //anchors.fill:children

    color:"transparent"
    property int opn
    property int time
    property alias team:team.text
    property alias from_kart:from_kart.text
    property alias to_kart:to_kart.text
    property int old_q
    property int new_q
    width:childrenRect.width
    height:childrenRect.height+1

    onTimeChanged: optime.text=Util.intToTime(time)

    Row {
        //width:200
        //height:50
        spacing: 4



        Image {
            source:"img/l_time.png"
            Text {
                text:Util.intToTime(time)
                id:optime
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
            source:{  switch (old_q ) {
                case -2:
                    "img/l_K1.png"
                    break
                case -1:
                    "img/l_K2.png"
                    break
                case 0:
                    "img/l_K3.png"
                    break
                case 1:
                    "img/l_K5.png"
                    break
                case 2:
                    "img/l_K6.png"
                    break
                default:
                    "img/l_K4.png"
                }
            }
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
            source:{  switch (new_q ) {
                case -2:
                    "img/l_K1.png"
                    break
                case -1:
                    "img/l_K2.png"
                    break
                case 0:
                    "img/l_K3.png"
                    break
                case 1:
                    "img/l_K5.png"
                    break
                case 2:
                    "img/l_K6.png"
                    break
                default:
                    "img/l_K4.png"
                }
            }



            Text {
                id:to_kart
                anchors.centerIn:parent
            }

        }
    }
}
