import QtQuick 1.1
Rectangle {
    id:ti
    width:40
    height:30
    property alias text:text.text
    property alias validator:text.validator
    anchors.right: parent.right

    signal accepted
    TextInput {
        id:text
        font.family: "Impact"
        font.pointSize: 20
        anchors.fill:parent
        //anchors.right:parent.right
        //anchors.rightMargin: 15
        color:"#0e232e"
        //color:"white"
        opacity:0.95
        //anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignLeft
    }

    Component.onCompleted: text.accepted.connect(ti.accepted)
}
