import QtQuick 1.1

GridDecor {
    name:"Log"
    signal addOperation(int time,int team,int from_kart,int to_kart,int from_q,int to_q)
    signal reset()
    property int nextrec:0

    ListView {
        id:logManager
        anchors.fill:parent
        anchors.margins: 4
        clip:true
        snapMode: ListView.SnapToItem

        model:logList
        delegate: LogManagerLine {opn:model.opn;time:model.time; team:model.team; from_kart:model.from_kart; to_kart:model.to_kart; old_q:model.from_kart_q; new_q:model.to_kart_q}
    }

    onReset: {
        logManager.model.clear()
        nextrec=0
    }

    onAddOperation:{
        logManager.model.append({'opn':nextrec++,'time':time,'team':team,'from_kart':from_kart,'to_kart':to_kart,'from_kart_q':from_q,'to_kart_q':to_q})
        logManager.positionViewAtEnd()
    }

    function getLast() {
        var i=logManager.count
        if (i>0) {
            return logManager.model.get(i-1)
        }
        else {
            return  null
        }
    }

    function removeLast() {
        var i=logManager.count
        if (i>0) {
            logManager.model.remove(i-1)
        }
    }

}
