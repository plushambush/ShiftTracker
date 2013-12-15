import QtQuick 1.1

Text {
    id:racetime
    property int currenttime:0
    property int basetime:0

    text:intToTime(currenttime-basetime)

    signal tick(int time)
    signal reset()


    onTick: currenttime=time
    onReset: {
        currenttime=0
        basetime=0
    }
    onCurrenttimeChanged: text=intToTime(currenttime-basetime)
    onBasetimeChanged: text=intToTime(currenttime-basetime)

    function intToTime(v) {
        if (v<=0) return ""
        if (v>0) {
            var h=Math.floor(v/3600);
            var m=Math.floor((v % 3600) / 60);
            var s=(v % 3600) % 60;
            var ret="";

            if (h>0) ret=h.toString()+":"
            if (m<10) ret=ret+"0"+m.toString()+":";
            else ret=ret+m.toString()+":";
            if (s<10) ret=ret+"0"+s.toString();
            else ret=ret+s.toString();

            return ret;
        }
        return "--:--"
    }
}
