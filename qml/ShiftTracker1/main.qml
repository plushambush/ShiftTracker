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
        Column {
            anchors.fill:parent
            spacing: 20
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


            RaceManager {id:raceManager}
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

    }

    back:Settings {
        onGoBack:main.flipped=!main.flipped
    }





}


