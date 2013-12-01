import QtQuick 1.1

Rectangle {
    default property alias c:grid.children
    Grid {
        id:grid
        anchors.fill:parent
        rows: 3
        columns: 3
        spacing:3
    }
}
