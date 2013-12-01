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
        anchors.fill:parent
        id:race;

        ListModel {
            id: raceList
            ListElement { kart:1; team:1; quality:'';lifetime:0; hottime:10 }
            ListElement { kart:2; team:2; quality:'';lifetime:0; hottime:10 }
            ListElement { kart:3; team:3; quality:'';lifetime:0; hottime:10 }
            ListElement { kart:4; team:4; quality:'';lifetime:0; hottime:10 }
            ListElement { kart:5; team:5; quality:'';lifetime:0; hottime:10 }
            ListElement { kart:6; team:6; quality:'';lifetime:0; hottime:10 }
            ListElement { kart:7; team:7; quality:'';lifetime:0; hottime:10 }
            ListElement { kart:8; team:8; quality:'';lifetime:0; hottime:10 }
            ListElement { kart:9; team:9; quality:'';lifetime:0; hottime:10 }
            ListElement { kart:10; team:10; quality:'';lifetime:0; hottime:10 }
            ListElement { kart:11; team:11; quality:'';lifetime:0; hottime:10 }
            ListElement { kart:12; team:12; quality:'';lifetime:0; hottime:10 }
        }
        ListModel {
            id: pitList
            ListElement { kart:13; team:'';quality:'';lifetime:0; hottime:10}
            ListElement { kart:14; team:'';quality:'';lifetime:0; hottime:10}
            ListElement { kart:15; team:'';quality:'';lifetime:0; hottime:10}
            ListElement { kart:16; team:'';quality:'';lifetime:0; hottime:10}
        }
        Component {
            id:kartDelegate;
            Kart {team:model.team; num:kart; lifetime: model.lifetime; hottime: model.hottime; quality:model.quality}
        }
        Row {
            id: raceMenuRow
            height: 30
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            Rectangle {
                id: startStopRect
                width: parent.width/4
                color: "#ffffff"
                border.width: 1
                border.color: "black"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                state:"stopped"

                Text {
                    id: startStopText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (parent.state=="started") {
                            parent.state="stopped"
                            raceTimer.stop()
                        }
                        else {
                            parent.state="started"
                            raceTimer.start()

                        }
                    }

                }

                states:[
                    State {
                        name:"started"
                        PropertyChanges {
                            target: startStopText
                            text:"Stop"
                        }


                    },
                    State {
                        name:"stopped"
                        PropertyChanges {
                            target: startStopText
                            text: "Start"
                        }
                    }
                ]
            }

            Rectangle {
                id: settingsRect
                width: parent.width/4
                color: "#ffffff"
                border.width: 1
                border.color: "black"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0

                Text {
                    id: settingsText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Settings")

                }
                MouseArea {
                    anchors.fill:parent
                    onClicked: main.flipped = !main.flipped
                }
            }

            Rectangle {
                id: resetRect
                width: parent.width/4
                color: "#ffffff"
                border.width: 1
                border.color: "black"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0

                Text {
                    id: resetText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Reset")

                }
            }

            Rectangle {
                id: raceTimerRect
                width: parent.width/4
                color: "#ffffff"
                border.width: 1
                border.color: "black"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                RaceTime {
                    id:raceTimerText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    counter: 0
                }
                Timer {
                    id:raceTimer
                    interval:1000
                    repeat: true
                    running:false
                    triggeredOnStart: false

                    onTriggered: {
                        for(var i=0;i<raceList.count;i++) raceList.setProperty(i,'lifetime',raceList.get(i).lifetime+1)
                        raceTimerText.counter+=1

                    }

                }
            }
        }
        Column{
            id: column1
            width: 320
            height: 370
            anchors.top: raceMenuRow.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:50

            Rectangle{
                id: raceRect
                width:320
                height:240

                anchors.horizontalCenter: parent.horizontalCenter;
                GridView {
                    id: raceGrid
                    cacheBuffer:0
                    width: 320
                    height: 240
                    anchors.bottomMargin: 0
                    keyNavigationWraps: false

                    snapMode: GridView.SnapToRow
                    boundsBehavior: Flickable.StopAtBounds
                    flickableDirection: Flickable.AutoFlickDirection
                    model: raceList;
                    delegate:kartDelegate;

                    anchors.fill:parent;
                    cellWidth: 80;
                    cellHeight: 80;
                    anchors.horizontalCenter: parent.horizontalCenter;

                }
            }

            Rectangle {
                id: pitRect
                width: 320
                height: 80

                GridView {
                    id:pitGrid
                    snapMode: GridView.SnapOneRow
                    boundsBehavior: Flickable.StopAtBounds
                    flickableDirection: Flickable.AutoFlickDirection
                    anchors.fill:parent
                    contentWidth: 320
                    contentHeight: 80
                    //anchors.fill: parent
                    model: pitList
                    delegate: kartDelegate
                    cellWidth:80
                    cellHeight: 80
                }
            }



            Image {
                id: swapBtn
                x: 321
                y: 0
                width: 60
                height: 60
                anchors.verticalCenter: pitRect.verticalCenter
                fillMode: Image.PreserveAspectCrop
                source: "img/swap2.png"
                MouseArea {


                    function swapKart(index) {
                        var arrived_kart=raceList.get(index).kart
                        var arrived_team=raceList.get(index).team
                        var arrived_quality=raceList.get(index).quality
                        var new_kart=pitList.get(0).kart
                        var new_quality=pitList.get(0).quality

                        raceList.remove(index)
                        raceList.insert(0,{'kart':new_kart, 'team':arrived_team,'lifetime':0,'hottime':10})
                        pitList.remove(0)
                        pitList.append({'kart':arrived_kart,'quality':arrived_quality,'team':'',lifetime:0})

                    }



                    anchors.fill:parent
                    acceptedButtons: Qt.LeftButton
                    onClicked: {
                        swapKart(raceList.count-1)
                    }

                }
            }
        }

        Popup {
            id:racePopupMenu
            name:"RacePopupMenu"
            delegate:RacePopupMenu {}
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


