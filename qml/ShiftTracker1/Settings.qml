import QtQuick 1.1

Rectangle {
    id:settings
    anchors.fill:parent
    color:"#0e232e"

    signal goBack
    Column {
        anchors.fill:parent
        SettingsMenu{
            //onGoBack: goBack
        }
    }
}
