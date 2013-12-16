import QtQuick 1.1

Flipable {
    id:main
    width: 650
    height:550

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
    ListModel {id: logList}

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
                    raceTimer.reset()
                    raceManager.raceTimeReset()
                    raceMenu.raceTimeReset()
                    raceManager.reset()
                    logManager.reset()


                }
            }

            Row {

                spacing:30
                //anchors.left: parent.left
                //anchors.right:parent.right
                LogManager {id:logManager;width:250;height:490}
                RaceManager {id:raceManager;width:600; height:490}
            }
        }


        Timer {
            id:raceTimer
            interval:1000
            repeat: true
            running:false
            triggeredOnStart: false
            property int currenttime:0
            signal reset()

            onTriggered: {
                currenttime++
                raceManager.raceTimeTick(currenttime)
                raceMenu.raceTimeTick(currenttime)
            }
            onReset: {
                currenttime=0
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


