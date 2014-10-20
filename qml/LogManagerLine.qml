import QtQuick 1.1
import ":js/Util.js" 1.0 as Util

Rectangle {
    id:line
    //anchors.fill:children

    color:"transparent"
    property int opn
    property int time
    property alias team:team.text
    property alias from_kart:from_kart.text
    property alias to_kart:to_kart.text
    property alias old_q:fromKartIcon.quality
    property alias new_q:toKartIcon.quality
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
                font.pointSize: 14
            }
        }
        Image {
            source:"img/l_team.png"
            Text {
                id:team
                anchors.centerIn:parent
                font.pointSize: 14
            }
        }

        Rectangle {color:"transparent";width:20;height:20}
        VKartSmall {
            id: fromKartIcon
            Text {
                id:from_kart
                anchors.centerIn:parent
                font.pointSize: 14
            }
        }
        Image {
            source:"img/l_right.png"
            //anchors.verticalCenter: parent.verticalCenter
        }
        VKartSmall {
            id:toKartIcon
            Text {
                id:to_kart
                anchors.centerIn:parent
                font.pointSize: 14
            }

        }
    }
}
