import QtQuick 1.1

GridMenu {
    id:racePopupMenu
    width: 250
    height:250
    border.width: 3
    border.color:"red"
    radius:10
    opacity:0.8

    MenuElementIcon {
        icon:"img/K2.png"
        text:"Slow"
        eventid: "QUALITY_SLOW"
    }

    MenuElementIcon {
        icon:"img/K3.png"
        text:"Neutral"
        eventid: "QUALITY_NEUTRAL"
    }

    MenuElementIcon {
        icon:"img/K5.png"
        text:"Fast"
        eventid: "QUALITY_FAST"
    }

    MenuElementIcon {
        icon:"img/K1.png"
        text:"Trash"
        eventid: "QUALITY_TRASH"
    }

    MenuElementIcon {
        icon:"img/K4.png"
        text:"Unknown"
        eventid: "QUALITY_UNKNOWN"
    }

    MenuElementIcon {
        icon:"img/K6.png"
        text:"Rocket"
        eventid: "QUALITY_ROCKET"
    }

    Rectangle {width:60;height:60;color:"transparent"}

    MenuElementIcon {
        icon:"img/tool2.png"
        text:"Remove"
        eventid: "KART_REMOVE"
    }
    Rectangle {width:60;height:60;color:"transparent"}
}


