import QtQuick 1.1
import "Sort.js" 1.0 as Sort

Column{
    id: raceManager
    //property int racePoolSize:12
    //property int pitPoolSize:4
    //property int sparePoolSize:2
    //property int hottime:10
    property string sortorder:"number"
    anchors.horizontalCenter: parent.horizontalCenter
    spacing:30


    GridDecor {
        id: raceRect
        name:"Race"
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
        name:"Pit"
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
            clip:true
            flow:GridView.TopToBottom

            cellWidth:70
            cellHeight: 70
            model: pitList
            delegate: Item {
                VKart {id:pkart;num:kart; quality:model.quality}
                MouseArea {
                    anchors.fill:pkart
                    onClicked:pitPopupMenu.openPopupMenuFor(pkart,"PitPopupMenu",pkart.num,raceManager)
                }
            }
        }
    }

    GridDecor {
        id: spareRect
        name:"Spare"
        width: 320
        height: 80
        visible:false
        GridView {
            id:spareGrid
            anchors.topMargin: 6
            anchors.leftMargin: 12
            anchors.fill: parent
            snapMode: GridView.SnapOneRow
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.AutoFlickDirection
            clip:true
            flow:GridView.TopToBottom

            cellWidth:70
            cellHeight: 70
            model: spareList
            delegate: Item {
                VKart {id:skart;team:model.team; num:kart; lifetime: model.lifetime; hottime: model.hottime; quality:model.quality}
                MouseArea {
                    anchors.fill:skart
                    onClicked:sparePopupMenu.openPopupMenuFor(skart,"SparePopupMenu",skart.num,raceManager)
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
        source: "img/swap.png"
        MouseArea {
            anchors.fill:parent
            acceptedButtons: Qt.LeftButton
            onClicked: {
                shiftPopupMenu.openPopupMenuFor(swapBtn,"ShiftPopupMenu",raceList,raceManager)
            }
        }
    }

    SideMenu {
        id:sideMenu
        anchors.top: raceRect.top
        anchors.left:raceRect.right
        anchors.leftMargin: 2
        onMenuSelected: raceManager.sortorder=eventid
    }

    signal menuSelected(string menuName,string menuItem,variant tag)
    signal raceTimeTick()
    signal raceTimeReset()
    signal reset()

    onRaceTimeTick: {
        for(var i=0;i<raceList.count;i++) raceList.setProperty(i,'lifetime',raceList.get(i).lifetime+1)

    }

    onRaceTimeReset: {
        for(var i=0;i<raceList.count;i++) raceList.setProperty(i,'lifetime',0)
    }

    onReset: {
        raceList.clear()
        pitList.clear()
        var lastnum
        lastnum=fillListWithKarts(raceList,main.kartsInRace,1)
        lastnum=fillListWithKarts(pitList,main.kartsInPit,lastnum)
        lastnum=fillListWithKarts(spareList,main.kartsInSpare,lastnum)
        fillListWithTeams(raceList,1)
        sortorder="kart"
        sortRaceList()
    }

    Component.onCompleted: reset()

    onMenuSelected: {
        switch (menuName) {
        case "RacePopupMenu": {
            var i=getIndexByProp(raceList,'kart',tag)
            switch (menuItem) {
            case "QUALITY_SLOW": {raceList.setProperty(i,'quality',-1);break}
            case "QUALITY_NEUTRAL": {raceList.setProperty(i,'quality',0);break}
            case "QUALITY_FAST": {raceList.setProperty(i,'quality',1);break}
            case "QUALITY_TRASH": {raceList.setProperty(i,'quality',-2);break}
            case "QUALITY_UNKNOWN":{ raceList.setProperty(i,'quality',-5);break}
            case "QUALITY_ROCKET": {raceList.setProperty(i,'quality',2);break}
            case "KART_DELETE": {raceList.remove(i);break}
            case "KART_SHIFT":{swapKart(i);break}
            }
            sortRaceList()
            break
        }
        case "PitPopupMenu": {
            var i=getIndexByProp(pitList,'kart',tag)
            switch (menuItem) {
            case "QUALITY_SLOW": {pitList.setProperty(i,'quality',-1);break}
            case "QUALITY_NEUTRAL": {pitList.setProperty(i,'quality',0);break}
            case "QUALITY_FAST": {pitList.setProperty(i,'quality',1);break}
            case "QUALITY_TRASH": {pitList.setProperty(i,'quality',-2);break}
            case "QUALITY_UNKNOWN": {pitList.setProperty(i,'quality',-5);break}
            case "QUALITY_ROCKET": {pitList.setProperty(i,'quality',2);break}
            case "KART_DELETE": {pitList.remove(i);break}
            }
            break
        }
        case "ShiftPopupMenu": {
            var i=getIndexByProp(raceList,'team',menuItem)
            swapKart(i)
            sortRaceList()
            break
        }
        }
    }

    function getIndexByProp(list,prop,val) {
        for (var i=0;i<list.count;i++) {
            if (Sort.qs_prop(list,i,prop)==val) {
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
        raceList.insert(0,{'kart':new_kart, 'team':arrived_team,'quality':new_quality,'lifetime':0,'hottime':main.timeToShift*60})
        pitList.remove(0)
        pitList.append({'kart':arrived_kart,'quality':arrived_quality,'team':'','lifetime':0})

    }
    function fillListWithKarts(list,size,startfrom) {
        var kart=startfrom
        for (var i=1;i<=size;i++) {
            list.append({'kart':kart++,'team':'','lifetime':0,'quality':-5,'hottime':main.timeToShift*60})
        }
        return kart
    }

    function fillListWithTeams(list,startfrom) {
        var team=startfrom
        for (var i=0;i<list.count;i++) {
            list.setProperty(i,'team',team++)
        }
        return team
    }

    function sortRaceList() {
        Sort.qsort(raceList,sortorder)
    }

    onSortorderChanged: sortRaceList()

}
