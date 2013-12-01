import QtQuick 1.1

Image {
    id:kartback
    property int quality:1
    property alias text:text.text
    source:qtoSrc(quality)
    width:sourceSize.width
    height:sourceSize.height


    onQualityChanged: {
        source=qtoSrc(quality)
    }

    function qtoSrc(q) {
        switch (q) {
        case -2:
            return "img/K1.png"
        case -1:
            return "img/K2.png"
        case 0:
            return "img/K3.png"
        case 1:
            return "img/K5.png"
        case 2:
            return "img/K6.png"
        default:
            return "img/K4.png"
        }
    }
    Text {
        id: text;
        text:"Name"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        font.family: "Sans";
        font.pointSize: 10;
        anchors.right:parent.right;
        anchors.rightMargin: 3;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 3;
    }


}
