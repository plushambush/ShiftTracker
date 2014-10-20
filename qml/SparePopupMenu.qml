import QtQuick 1.1

GridMenu {
    id:sparePopupMenu
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

    MenuElementIcon {
        icon:"img/up.png"
        text:"To pit"
        eventid: "KART_TOPIT"
    }

    MenuElementIcon {
        icon:"img/ok.png"
        text:"Repaired"
        eventid: "KART_REPAIRED"
    }

    MenuElementIcon {
        icon:"img/tool.png"
        text:"Broken"
        eventid: "KART_BROKEN"
    }



}


