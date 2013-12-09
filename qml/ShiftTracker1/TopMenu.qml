import QtQuick 1.1

HorizontalMenu {
    HorizontalMenuItem {
        id:settings
        text:"Settings"
        onHorizontalMenuItemClicked: showSettings()
    }
    HorizontalMenuItem {
        id:startstop
        text:"Start"
        state:"Stopped"
        states: [
            State {
                name:"Stopped"
                PropertyChanges {
                    target: startstop
                    text:"Start"
                }
            },
            State {
                name:"Started"
                PropertyChanges {
                    target: startstop
                    text:"Stop"
                }
            }

        ]
        onHorizontalMenuItemClicked: {
            if (startstop.state=="Started") {
                stopRace()
                startstop.state="Stopped"
            }
            else {
                startRace()
                startstop.state="Started"
            }
        }
    }
    HorizontalMenuItem {
        id:reset
        text:"Reset"
        onHorizontalMenuItemClicked: resetRace()
    }
    HorizontalMenuItem {
        id:timer
        text:time.text
        RaceTime {id:time;visible:false}
    }

    signal showSettings
    signal startRace
    signal stopRace
    signal resetRace
    signal raceTimeReset()
    signal raceTimeTick()

    onRaceTimeTick: time.counter++

    onRaceTimeReset: time.counter=0



}


