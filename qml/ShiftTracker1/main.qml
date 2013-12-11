import QtQuick 1.1

Flipable {
    id:main
    width: 650
    height:600

    property bool flipped: false
    transform: Rotation {
        id: rotation
        origin.x: main.width/2
        origin.y: main.height/2
        axis.x: 0; axis.y: 1; axis.z: 0
        angle: 0
    }
    states: State {
        name: "back"
        PropertyChanges { target: rotation; angle: 180 }
        when: flipped
    }
    transitions: Transition {
        NumberAnimation { target: rotation; property: "angle"; duration: 500 }
    }

    ListModel {id: raceList}
    ListModel {id: pitList}
    ListModel {id: spareList}
    ListModel {
        id: logList
        ListElement {
            opn:0
            time:10
            team:12
            from_kart:1
            to_kart:2
        }
        ListElement {
            opn:0
            time:10
            team:12
            from_kart:1
            to_kart:2
        }
    }

    property int kartsInRace:12
    property int kartsInPit:4
    property int kartsInSpare:3
    property int timeToShift:45

    front:Root {
        id:root;
        Column {
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.fill:parent
            spacing: 25
            TopMenu {
                id:raceMenu
                onStartRace: raceTimer.start()
                onStopRace: raceTimer.stop()
                onShowSettings: main.flipped=!main.flipped
                onResetRace: {
                    raceTimer.stop()
                    raceManager.raceTimeReset()
                    raceMenu.raceTimeReset()
                    raceManager.reset()
                }
            }

            Row {

                spacing:30
                //anchors.left: parent.left
                //anchors.right:parent.right
                LogManager {id:logManager;width:250;height:520}
                RaceManager {id:raceManager;width:600; height:520}
            }
        }


        Timer {
            id:raceTimer
            interval:1000
            repeat: true
            running:false
            triggeredOnStart: false

            onTriggered: {
                raceManager.raceTimeTick()
                raceMenu.raceTimeTick()
            }
        }

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

        Popup {
            id:shiftPopupMenu
            name:"ShiftPopupMenu"
            delegate:ShiftPopupMenu {}
        }

        Popup {
            id:sparePopupMenu
            name:"SparePopupMenu"
            delegate:SparePopupMenu {}
        }


    }

    back:Settings {
        onGoBack: {
             main.flipped=!main.flipped
        }
    }





}


