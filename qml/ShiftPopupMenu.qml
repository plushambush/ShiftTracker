import QtQuick 1.1

MenuDecor {
    id:shiftPopupRect
    width:260
    height:200

    signal menuItemSelected(string eventid)

    onMenuItemSelected: {
        console.log("Item")
    }

    GridView {
        anchors.fill:parent

        id: shiftPopupMenu
        cellWidth: 65
        cellHeight: 65
        model:raceList
        delegate: MenuElementCustom {
            eventid:model.team
            Image {
                source:"img/bigbadge.png"
                anchors.centerIn:parent
                Text {
                    font.family: "Arial"
                    font.pointSize: 24
                    font.bold:true
                    anchors.centerIn:parent
                    text:model.team
                }
            }
            onMenuItemSelected: shiftPopupRect.menuItemSelected(eventid)
        }

    }
}
