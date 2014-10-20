import QtQuick 1.1
import ":js/Util.js" 1.0 as Util

Column{
    id: raceManager
    property string sortorder:"number"
    //anchors.horizontalCenter: parent.horizontalCenter
    width:320
    spacing:20

    property int rt:0



    GridDecor {
        id: raceRect
        name:"Race"
        width:294
        height:294
        //anchors.horizontalCenter: parent.horizontalCenter;
        GridView {
            id: raceGrid
            boundsBehavior: Flickable.StopAtBounds
            anchors.topMargin: 5
            anchors.leftMargin: 5
            anchors.fill: parent

            cellWidth: 72
            cellHeight: 72
            snapMode: GridView.SnapToRow
            model: raceList;
            delegate: Item {
                VKart {id:rkart;team:model.team; num:kart; optime: model.optime; currenttime:model.currenttime;hottime: model.hottime; quality:model.quality; broken:model.broken}
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
        width: 294
        height: 80
        GridView {
            id:pitGrid
            anchors.topMargin: 5
            anchors.leftMargin: 5
            anchors.fill: parent
            snapMode: GridView.SnapOneRow
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.AutoFlickDirection
            clip:true
            flow:GridView.TopToBottom

            cellWidth:66
            cellHeight: 72
            model: pitList
            delegate: Item {
                VKart {id:pkart;num:kart; quality:model.quality; broken:model.broken}
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
        width: 294
        height: 80
        anchors.bottom:raceManager.bottom

        GridView {
            id:spareGrid
            anchors.topMargin: 5
            anchors.leftMargin: 5
            anchors.fill: parent
            snapMode: GridView.SnapOneRow
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.AutoFlickDirection
            clip:true
            flow:GridView.TopToBottom

            cellWidth:66
            cellHeight: 72
            model: spareList
            delegate: Item {
                VKart {id:skart;team:model.team; num:kart; optime: model.optime; currenttime:model.currenttime;hottime: model.hottime; quality:model.quality; broken:model.broken}
                MouseArea {
                    anchors.fill:skart
                    onClicked:sparePopupMenu.openPopupMenuFor(skart,"SparePopupMenu",skart.num,raceManager)
                }
            }
        }
    }


    Image {
        id: swapBtn
        width: 60
        height: 60
        anchors.verticalCenter: pitRect.verticalCenter
        anchors.left:pitRect.right
        anchors.leftMargin: 2
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

    Image {
        id: undoBtn
        width: 60
        height: 60
        anchors.verticalCenter: spareRect.verticalCenter
        anchors.left:spareRect.right
        anchors.leftMargin: 2
        fillMode: Image.PreserveAspectCrop
        source: "img/undo.png"
        MouseArea {
            anchors.fill:parent
            acceptedButtons: Qt.LeftButton
            onClicked: {
                raceUndoShift()
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
    signal raceTimeTick(int time)
    signal raceTimeReset()
    signal reset()

    onRaceTimeTick: {
        rt=time
        for(var i=0;i<raceList.count;i++) raceList.setProperty(i,'currenttime',time)

    }

    onRaceTimeReset: {
        rt=0
        for(var i=0;i<raceList.count;i++) {
            raceList.setProperty(i,'currenttime',0)
            raceList.setProperty(i,'optime',0)
        }
    }

    onReset: {
        raceList.clear()
        pitList.clear()
        spareList.clear()

        logManager.reset
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
            var team=raceList.get(i).team
            switch (menuItem) {
            case "QUALITY_SLOW": {setQuality(raceList,tag,-1);break}
            case "QUALITY_NEUTRAL": {setQuality(raceList,tag,0);break}
            case "QUALITY_FAST": {setQuality(raceList,tag,1);break}
            case "QUALITY_TRASH": {setQuality(raceList,tag,-2);break}
            case "QUALITY_UNKNOWN":{setQuality(raceList,tag,-5);break}
            case "QUALITY_ROCKET": {setQuality(raceList,tag,2);break}
            case "KART_BREAKAGE": {raceDoBreakage(raceList,pitList,spareList,team);break}
            case "KART_SHIFT":{raceDoShift(raceList,pitList,spareList,team);break}
            case "TEAM_DISQUAL":{raceDoDisqual(raceList,pitList,spareList,team);break}
            }
            sortRaceList()
            break
        }
        case "PitPopupMenu": {
            var i=getIndexByProp(pitList,'kart',tag)

            switch (menuItem) {
            case "QUALITY_SLOW": {setQuality(pitList,tag,-1);break}
            case "QUALITY_NEUTRAL": {setQuality(pitList,tag,0);break}
            case "QUALITY_FAST": {setQuality(pitList,tag,1);break}
            case "QUALITY_TRASH": {setQuality(pitList,tag,-2);break}
            case "QUALITY_UNKNOWN": {setQuality(pitList,tag,-5);break}
            case "QUALITY_ROCKET": {setQuality(pitList,tag,2);break}
            case "KART_MOVE": {pitDoMove(raceList,pitList,spareList,tag);break}
            case "KART_TOSPARE": {pitDoToSpare(raceList,pitList,spareList,tag);break}
            case "KART_BROKEN": {pitList.setProperty(i,'broken',true);break}
            }
            break
        }
        case "SparePopupMenu": {
            var i=getIndexByProp(spareList,'kart',tag)

            switch (menuItem) {
            case "QUALITY_SLOW": {setQuality(spareList,tag,-1);break}
            case "QUALITY_NEUTRAL": {setQuality(spareList,tag,0);break}
            case "QUALITY_FAST": {setQuality(spareList,tag,1);break}
            case "QUALITY_TRASH": {setQuality(spareList,tag,-2);break}
            case "QUALITY_UNKNOWN": {setQuality(spareList,tag,-5);break}
            case "QUALITY_ROCKET": {setQuality(spareList,tag,2);break}
            case "KART_TOPIT": {spareDoToPit(raceList,pitList,spareList,tag);break}
            case "KART_BROKEN": {spareList.setProperty(i,'broken',true);break}
            case "KART_REPAIRED": {spareList.setProperty(i,'broken',false);break}
            }
            break
        }

        case "ShiftPopupMenu": {
            raceDoShift(raceList,pitList,spareList,menuItem)
            sortRaceList()
            break
        }
        }
    }


    function setQuality(list,kart,quality)  {
        var i=getIndexByProp(list,'kart',kart)
        list.setProperty(i,'quality',quality)
        logManager.updateQuality(kart,quality)
    }

    function getIndexByProp(list,prop,val) {
        for (var i=0;i<list.count;i++) {
            if (Util.qs_prop(list,i,prop)==val) {
                return i
            }
        }
        return null
    }


    function raceDoShift(raceList,pitList,spareList,team) {
        var index=getIndexByProp(raceList,'team',team)
        var old_kart=raceList.get(index).kart
        var old_quality=raceList.get(index).quality
        var old_bt=raceList.get(index).optime
        var new_kart=pitList.get(0).kart
        var new_quality=pitList.get(0).quality

        raceList.remove(index)
        raceList.insert(0,{'kart':new_kart, 'team':team,'quality':new_quality,'optime':rt,'curenttime':rt,'hottime':main.timeToShift*60,'broken':false})
        pitList.remove(0)
        pitList.append({'kart':old_kart,'quality':old_quality,'team':null,'optime':0,'broken':false})
        logManager.addOperation(rt,old_bt,team,old_kart,new_kart,old_quality,new_quality)

    }


    function raceUndoShift() {
        var obj=logManager.getLast()
        if (obj) {
            var time=obj.time
            var team=obj.team
            var from_kart=obj.from_kart
            var to_kart=obj.to_kart
            var from_q=obj.from_kart_q
            var to_q=obj.to_kart_q
            var opn=obj.opn
            var old_bt=obj.old_bt

            var oldkart=getIndexByProp(raceList,'team',team)
            raceList.setProperty(oldkart,'kart',from_kart)
            raceList.setProperty(oldkart,'quality',from_q)
            raceList.setProperty(oldkart,'optime',old_bt)
            raceList.setProperty(oldkart,'currenttime',rt)

            pitList.insert(0,{'kart':to_kart,'quality':to_q})
            if (getIndexByProp(pitList,'kart',from_kart)) {
                var i=getIndexByProp(pitList,'kart',from_kart)
                pitList.remove(i)
            }
            if (getIndexByProp(spareList,'kart',from_kart)) {
                var i=getIndexByProp(spareList,'kart',from_kart)
                spareList.remove(i)
            }
            logManager.removeLast()
            sortRaceList()
        }
    }

    function raceDoDisqual(raceList,pitList,spareList,team) {
        var index=getIndexByProp(raceList,'team',team)
        var old_kart=raceList.get(index).kart
        var old_quality=raceList.get(index).quality
        raceList.remove(index)
        pitList.append({'kart':old_kart,'quality':old_quality,'team':null,'lifetime':0})
    }

    function raceDoBreakage(raceList,pitList,spareList,team) {
        var index=getIndexByProp(raceList,'team',team)
        var old_kart=raceList.get(index).kart
        var old_quality=raceList.get(index).quality
        var old_bt=raceList.get(index).optime
        var new_kart=pitList.get(0).kart
        var new_quality=pitList.get(0).quality

        raceList.remove(index)
        raceList.insert(0,{'kart':new_kart, 'team':team,'quality':new_quality,'optime':rt,'currenttime':rt,'hottime':main.timeToShift*60,'broken':false})
        pitList.remove(0)
        pitList.append({'kart':old_kart,'quality':old_quality,'team':null,'lifetime':0, 'broken':true})
        logManager.addOperation(rt,old_bt,team,old_kart,new_kart,old_quality,new_quality)
    }

    function pitDoMove(raceList,pitList,spareList,kart) {
        var index=getIndexByProp(pitList,'kart',kart)
        if (index!=0) {
            Util.qs_swap(pitList,index-1,index,'kart')
        }
    }

    function pitDoToSpare(raceList,pitList,spareList,kart) {
        var index=getIndexByProp(pitList,'kart',kart)
        var old_kart=pitList.get(index).kart
        var old_quality=pitList.get(index).quality
        var old_broken=pitList.get(index).broken
        spareList.append({'kart':old_kart,'quality':old_quality,'broken':old_broken})
        pitList.remove(index)


    }

    function spareDoToPit(raceList,pitList,spareList,kart) {
        var index=getIndexByProp(spareList,'kart',kart)
        var old_kart=spareList.get(index).kart
        var old_quality=spareList.get(index).quality
        var old_broken=spareList.get(index).broken
        pitList.append({'kart':old_kart,'quality':old_quality,'broken':old_broken})
        spareList.remove(index)


    }


    function fillListWithKarts(list,size,startfrom) {
        var kart=startfrom
        for (var i=1;i<=size;i++) {
            list.append({'kart':kart++,'team':null,'optime':0,'currenttime':0,'quality':-5,'hottime':main.timeToShift*60, 'broken':false})
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
        Util.qsort(raceList,sortorder)
    }

    onSortorderChanged: sortRaceList()

}
