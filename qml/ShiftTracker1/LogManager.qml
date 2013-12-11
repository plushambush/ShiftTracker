import QtQuick 1.1

GridDecor {
    name:"Log"

    ListView {
        id:logManager
        anchors.fill:parent
        anchors.margins: 4
        property int nextrec:0

        model:logList
        delegate: LogManagerLine {opn:model.opn;time:model.time; team:model.team; from_kart:model.from_kart; to_kart:model.to_kart}


        function reset() {
            logList.clear()
            nextrec=0
        }

        function addOperation(time,team,from_kart,to_kart) {
            logList.append({'opn':nextrec++,'time':time,'team':team,'from_kart':from_kart,'to_kart':to_kart})
        }
    }

}
