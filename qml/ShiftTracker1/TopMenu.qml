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
        onHorizontalMenuItemClicked: {
            startstop.state="Stopped"
            resetRace()
        }
    }
    HorizontalMenuItem {
        id:timer
        text:rtime.text
        RaceTime {id:rtime;visible:false}
    }

    signal showSettings()
    signal startRace()
    signal stopRace()
    signal resetRace()
    signal raceTimeReset()
    signal raceTimeTick(int time)

    onRaceTimeTick: rtime.tick(time)

    onRaceTimeReset: rtime.reset()



}


