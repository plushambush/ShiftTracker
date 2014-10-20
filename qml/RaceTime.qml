import QtQuick 1.1
import ":js/Util.js" 1.0 as Util

Text {
    id:racetime
    property int currenttime:0
    property int basetime:0

    text:Util.intToTime(currenttime-basetime)

    signal tick(int time)
    signal reset()


    onTick: {
        currenttime=time
    }
    onReset: {
        currenttime=0
        basetime=0
    }
    onCurrenttimeChanged: {
        text=Util.intToTime(currenttime-basetime)
    }
    onBasetimeChanged: {
        text=Util.intToTime(currenttime-basetime)
    }


}
