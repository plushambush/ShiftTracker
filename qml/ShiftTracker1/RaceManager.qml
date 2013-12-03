import QtQuick 1.1

Column{
    id: raceManager
    //width: 320
    //height: 370
    anchors.top: raceMenuRow.bottom
    anchors.topMargin: 20
    anchors.horizontalCenter: parent.horizontalCenter
    spacing:20

    ListModel {
        id: raceList
        ListElement { kart:1; team:1; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:2; team:2; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:3; team:3; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:4; team:4; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:5; team:5; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:6; team:6; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:7; team:7; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:8; team:8; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:9; team:9; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:10; team:10; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:11; team:11; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:12; team:12; quality:'';lifetime:0; hottime:10 }
        ListElement { kart:17; team:17; quality:'';lifetime:0; hottime:10 }
    }

    ListModel {
        id: pitList
        ListElement { kart:13; team:'';quality:'';lifetime:0; hottime:10}
        ListElement { kart:14; team:'';quality:'';lifetime:0; hottime:10}
        ListElement { kart:15; team:'';quality:'';lifetime:0; hottime:10}
        ListElement { kart:16; team:'';quality:'';lifetime:0; hottime:10}
        //ListElement { kart:18; team:'';quality:'';lifetime:0; hottime:10}
    }

    GridDecor {
        id: raceRect
        width:320
        height:320
        anchors.horizontalCenter: parent.horizontalCenter;
        GridView {
            id: raceGrid
            boundsBehavior: Flickable.StopAtBounds
            anchors.topMargin: 13
            anchors.leftMargin: 13
            anchors.fill: parent

            cellWidth: 75
            cellHeight: 75
            snapMode: GridView.SnapToRow
            model: raceList;
            delegate: Item {
                VKart {id:rkart;team:model.team; num:kart; lifetime: model.lifetime; hottime: model.hottime; quality:model.quality}
                MouseArea {
                    anchors.fill:rkart
                    onClicked:racePopupMenu.openPopupMenuFor(rkart,"RacePopupMenu",rkart.num,raceManager)
                }
            }
        }
    }

    GridDecor {
        id: pitRect
        width: 320
        height: 80
        GridView {
            id:pitGrid
            anchors.topMargin: 6
            anchors.leftMargin: 12
            anchors.fill: parent
            snapMode: GridView.SnapOneRow
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.AutoFlickDirection
            //contentWidth: 420
            //contentHeight: 80
            clip:true
            flow:GridView.TopToBottom

            cellWidth:70
            cellHeight: 70
            model: pitList
            delegate: Item {
                VKart {id:pkart;team:model.team; num:kart; lifetime: model.lifetime; hottime: model.hottime; quality:model.quality}
                MouseArea {
                    anchors.fill:pkart
                    onClicked:pitPopupMenu.openPopupMenuFor(pkart,"PitPopupMenu",pkart.num,raceManager)
                }
            }
        }
    }

    Image {
        id: swapBtn
        x: 321
        y: 0
        width: 60
        height: 60
        anchors.verticalCenter: pitRect.verticalCenter
        fillMode: Image.PreserveAspectCrop
        source: "img/swap2.png"
        MouseArea {
            anchors.fill:parent
            acceptedButtons: Qt.LeftButton
            onClicked: {
                swapKart(raceList.count-1)
            }
        }
    }

    signal menuSelected(string menuName,string menuItem,variant tag)
    signal raceTimeTick()

    onRaceTimeTick: {
        for(var i=0;i<raceList.count;i++) raceList.setProperty(i,'lifetime',raceList.get(i).lifetime+1)
    }

    onMenuSelected: {
        switch (menuName) {
        case "RacePopupMenu": {
            var i=getIndexByKart(raceList,tag)
            switch (menuItem) {
            case "QUALITY_SLOW": raceList.setProperty(i,'quality',-1)
            case "QUALITY_NEUTRAL": raceList.setProperty(i,'quality',0)
            case "QUALITY_FAST": raceList.setProperty(i,'quality',1)
            case "QUALITY_TRASH": raceList.setProperty(i,'quality',-2)
            case "QUALITY_UNKNOWN": raceList.setProperty(i,'quality',-5)
            case "QUALITY_ROCKET": raceList.setProperty(i,'quality',2)
            case "KART_DELETE": raceList.remove(i)
            }
        }
        case "PitPopupMenu": {
            var i=getIndexByKart(pitList,tag)
            switch (menuItem) {
            case "QUALITY_SLOW": pitList.setProperty(i,'quality',-1)
            case "QUALITY_NEUTRAL": pitList.setProperty(i,'quality',0)
            case "QUALITY_FAST": pitList.setProperty(i,'quality',1)
            case "QUALITY_TRASH": pitList.setProperty(i,'quality',-2)
            case "QUALITY_UNKNOWN": pitList.setProperty(i,'quality',-5)
            case "QUALITY_ROCKET": pitList.setProperty(i,'quality',2)
            case "KART_DELETE": pitList.remove(i)
            }
        }
        }
    }

    function getIndexByKart(list,kart) {
        for (var i=0;i<list.count;i++) {
            if (list.get(i).kart==kart) {
                return i
            }
        }
        return null
    }


    function swapKart(index) {
        var arrived_kart=raceList.get(index).kart
        var arrived_team=raceList.get(index).team
        var arrived_quality=raceList.get(index).quality
        var new_kart=pitList.get(0).kart
        var new_quality=pitList.get(0).quality

        raceList.remove(index)
        raceList.insert(0,{'kart':new_kart, 'team':arrived_team,'quality':new_quality,'lifetime':0,'hottime':10})
        pitList.remove(0)
        pitList.append({'kart':arrived_kart,'quality':arrived_quality,'team':'','lifetime':0})

    }

}
