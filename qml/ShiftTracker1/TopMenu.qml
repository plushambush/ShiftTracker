import QtQuick 1.1


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
                raceManager.raceTimeTick()
                raceTimerText.counter+=1

            }

        }
    }
}
