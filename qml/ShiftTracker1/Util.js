.pragma library

function qs_swap(list,a,b,prop) {
    if ((a===b) || (qs_prop(list,a,prop)===qs_prop(list,b,prop))) return
    if (a<b) {
        list.move(b,a,1)
        list.move(a+1,b,1)
    }
    else {
        list.move(a,b,1)
        list.move(b+1,a,1)
    }
}
function qs_prop(list,index,prop) {
    var p
    if ((prop[0]==='-') || (prop[0]==='+')) {
            p=prop.substring(1)
    }
    else {
        p=prop
    }

    var o=list.get(index)
    if (o) {
        return o[p]
    }
    else {
        return null
    }
}

function qs_propsign(prop) {
    if (prop[0]==='-') {
        return false
    }
    else {
        return true
    }
}

function qs_part (list,begin,end,pivot,prop) {
    var piv=qs_prop(list,pivot,prop)
    qs_swap(list,pivot, end-1,prop);
    var store=begin;
    var ix;
    if (qs_propsign(prop)) {
        for(ix=begin; ix<end-1; ++ix) {
            if(qs_prop(list,ix,prop)<=piv) {
                qs_swap(list,store, ix,prop);
                ++store;
            }
        }
    }
    else {
        for(ix=begin; ix<end-1; ++ix) {
            if(qs_prop(list,ix,prop)>=piv) {
                qs_swap(list,store, ix,prop);
                ++store;
            }
        }
    }

    qs_swap(list,end-1, store,prop);
    return store;
}

function qs_sort(list,prop,begin,end) {
    if (end-1>begin) {
        var pivot=begin+Math.floor(Math.random()*(end-begin))
        pivot=qs_part(list,begin,end,pivot,prop)
        qs_sort(list,prop,begin,pivot)
        qs_sort(list,prop,pivot+1,end)
    }
}
function qsort(list,prop){
    qs_sort(list,prop,0,list.count)

}

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
