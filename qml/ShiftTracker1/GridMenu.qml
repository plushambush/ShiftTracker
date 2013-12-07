import QtQuick 1.1

MenuDecor {
    default property alias c:grid.children
    width:childrenRect.width+5
    height:childrenRect.height+5
    Grid {
        id:grid
        anchors.centerIn: parent
        rows: 3
        columns: 3
        spacing:3

    }
}
