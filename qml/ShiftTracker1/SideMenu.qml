import QtQuick 1.1

Column {
    spacing: 4
    signal menuSelected(string eventid)

    MenuElementIconOnly {
        radius:4
        icon:"img/sortq.png"
        eventid:"quality"
        onMenuItemSelected: menuSelected(eventid)
    }
    MenuElementIconOnly {
        radius:4
        icon:"img/sortn.png"
        eventid:"team"
        onMenuItemSelected: menuSelected(eventid)
    }
    MenuElementIconOnly {
        radius:4
        icon:"img/sortk.png"
        eventid:"kart"
        onMenuItemSelected: menuSelected(eventid)
    }
    MenuElementIconOnly {
        radius:4
        icon:"img/sortt.png"
        eventid:"lifetime"
        onMenuItemSelected: menuSelected(eventid)
    }

}
