import QtQuick 1.1

Rectangle {
    id: kart;
    width: 65
    height: 65;
    color: "transparent";
    state: "normal";

    property alias team: team_num.text;
    property alias num: kart_num.text;
    property alias optime: time_text.basetime
    property alias currenttime:time_text.currenttime
    property int quality:-5;
    property int hottime
    property alias broken:broken_img.visible


    onCurrenttimeChanged:   {
        if ((currenttime-optime)>hottime) {
            kart.state= "hot"
        }
        else {
            kart.state= "normal"
        }
    }

    onHottimeChanged: {
        if ((currenttime-optime)>hottime) {
            kart.state= "hot";
        }
        else {
            kart.state= "normal";
        }
    }

    onOptimeChanged: {
        if ((currenttime-optime)>hottime) {
            kart.state= "hot";
        }
        else {
            kart.state= "normal";
        }
    }


    onTeamChanged: {
        if ((!team) || (team=='')) {
            kart.state= "empty"
        }

    }


    onQualityChanged: {
        switch (quality ) {
        case -2:
            back.source="img/K1.png"
            break
        case -1:
            back.source="img/K2.png"
            break
        case 0:
            back.source="img/K3.png"
            break
        case 1:
            back.source="img/K5.png"
            break
        case 2:
            back.source="img/K6.png"
            break
        default:
            back.source="img/K4.png"
        }
    }

    states: [
        State {
            name: "hot";
        },
        State {
            name: "normal";
        },
        State {
            name: "empty";
            when: team==""
            PropertyChanges {
                target:badge;
                visible: false;

            }
            PropertyChanges {
                target:time_text;
                visible:false;
            }
            PropertyChanges {
                target:kart_num;
                horizontalAlignment: "AlignHCenter"
                anchors.horizontalCenter: back.horizontalCenter;


            }
        }

      ]
    transitions: [
        Transition {
            from:"normal"
            to: "hot";
            animations: [jumping];
        },
        Transition {
            from:"hot"
            to: "normal";
            animations:[back_to_steady]
        }
    ]


    Rectangle  {
        id: kartframe;
        width:parent.width;
        height:parent.height;
        color: "transparent";
        transformOrigin: Item.Center;
        Image {
            id: back;
            smooth: true;
            source: "img/K4.png";
            x:5;
            y:5;
        }

        Image {
            id:broken_img
            source:"img/damaged.png"
            visible:false
            x:4
            y:4
        }

        Image {
            id: badge;
            smooth: true;
            source: "img/badge.png";
            Text {
                color:"#0e232e"
                id: team_num;
                text:"";
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Arial";
                font.pointSize: 12;
                font.bold: true;
                anchors.horizontalCenter: badge.horizontalCenter;
                anchors.verticalCenter: badge.verticalCenter;
                anchors.fill: badge;
            }
        }
        Text {
            id: kart_num;
            //text:"88";
            color:"#0e232e"
            smooth:true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            font.family:"Impact";

            font.pointSize: 22;
            font.bold:false;

            anchors.right: back.right;
            anchors.rightMargin: 3;
            anchors.bottom: back.bottom;
            anchors.bottomMargin: 15;
        }
        RaceTime {
            id: time_text;
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            color:"#0e232e"
            font.family: "Sans";
            font.pointSize: 10;
            anchors.right:back.right;
            anchors.rightMargin: 3;
            anchors.bottom: back.bottom;
            anchors.bottomMargin: 3;
        }


  }


  SequentialAnimation {
        id: jumping;
        PropertyAnimation {
            target: kartframe;
            property: "y";
            from: kartframe.y;
            to: kartframe.y-5;
        }

        SequentialAnimation {
            loops:Animation.Infinite

            ParallelAnimation {
                PropertyAnimation{
                    target: kartframe;
                    property:"rotation"
                    from:kartframe.rotation;
                    to:kartframe.rotation-5;
                    duration:245
                }
                PropertyAnimation {
                    target: kartframe;
                    property: "y";
                    from: kartframe.y-5;
                    to: kartframe.y;
                    duration:245
                }
            }

            ParallelAnimation {
                PropertyAnimation{
                    target: kartframe;
                    property:"rotation"
                    from:kartframe.rotation-5;
                    to:kartframe.rotation;
                    duration:245
                }
                PropertyAnimation {
                    target: kartframe;
                    property: "y";
                    from: kartframe.y;
                    to: kartframe.y-5;
                    duration:245
                }
            }

            ParallelAnimation {
                PropertyAnimation {
                    target:kartframe;
                    property:"y";
                    from:kartframe.y-5;
                    to:kartframe.y;
                    duration:245
                }
                PropertyAnimation{
                    target:kartframe;
                    property:"rotation";
                    from:kartframe.rotation;
                    to:kartframe.rotation+5;
                    duration:245
                }
            }

            ParallelAnimation {
                PropertyAnimation {
                    target:kartframe;
                    property:"y";
                    from:kartframe.y;
                    to:kartframe.y-5;
                    duration:245
                }
                PropertyAnimation{
                    target:kartframe;
                    property:"rotation";
                    from:kartframe.rotation+5;
                    to:kartframe.rotation;
                    duration:245
                }
            }
        }

    }
  ParallelAnimation {
        id:back_to_steady;
        PropertyAnimation {
            target: kartframe;
            property: "y";
            to: 0;
        }
        PropertyAnimation {
            target: kartframe;
            property: "rotation";
            to: 0;
        }
    }


}


