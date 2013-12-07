import QtQuick 1.1

Text {
    id:racetime
    property int counter:0
    text:intToTime(counter)


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
