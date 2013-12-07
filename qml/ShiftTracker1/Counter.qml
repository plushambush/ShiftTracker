import QtQuick 2.0

Item {
    property int value:0
    property int increment:1
    signal reset

    onReset: doReset()
    function nextValue() {
        var v=value
        value+=increment
        return v
    }

    function doReset() {
        value=0
    }
}
