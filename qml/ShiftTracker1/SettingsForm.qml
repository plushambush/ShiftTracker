import QtQuick 1.1


    Column {
        anchors.left:parent.left
        anchors.right:parent.right
        spacing:20
        property alias kartsInRaceValue:kartsInRaceInput.text
        property alias kartsInPitValue:kartsInPitInput.text
        property alias kartsInSpareValue:kartsInSpareInput.text
        property alias timeToShiftValue:timeToShiftInput.text

        Row {
            width: 400
            anchors.horizontalCenter: parent.horizontalCenter
            SettingsFormText {text:"Karts in race"}
            SettingsFormInput {
                id:kartsInRaceInput
                text:main.kartsInRace
                validator:IntValidator{bottom:1;top:16}
                onAccepted: main.kartsInRace=text
            }
        }
        Row {
            width: 400
            anchors.horizontalCenter: parent.horizontalCenter
            SettingsFormText {text:"Karts on pit lane"}
            SettingsFormInput {
                id:kartsInPitInput
                text:main.kartsInPit
                validator:IntValidator{bottom:1;top:6}
                onAccepted: main.kartsInPit=text
            }
        }
        Row {
            width: 400
            anchors.horizontalCenter: parent.horizontalCenter
            SettingsFormText {text:"Spare karts"}
            SettingsFormInput {
                id:kartsInSpareInput
                text:main.kartsInSpare
                validator:IntValidator{bottom:0;top:6}
                onAccepted: main.kartsInSpare=text
            }
        }
        Row {
            width: 400
            anchors.horizontalCenter: parent.horizontalCenter
            SettingsFormText {text:"Time to shift (minutes)"}
            SettingsFormInput {
                id:timeToShiftInput
                text:main.timeToShift
                validator:IntValidator{bottom:1;top:60}
                onAccepted: main.timeToShift=text
            }
        }
    }

