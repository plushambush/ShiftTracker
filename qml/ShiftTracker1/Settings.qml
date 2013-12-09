import QtQuick 1.1

Rectangle {
    id:settings
    anchors.fill:parent
    color:"#0e232e"


    signal goBack
    Column {
        anchors.fill:parent
        SettingsMenu{
            onGoBackPressed: {
                main.kartsInRace=settingsForm.kartsInRaceValue
                main.kartsInPit=settingsForm.kartsInPitValue
                main.kartsInSpare=settingsForm.kartsInSpareValue
                main.timeToShift=settingsForm.timeToShiftValue
                goBack()
            }

        }
        SettingsForm {
            id:settingsForm

        }
    }
}
