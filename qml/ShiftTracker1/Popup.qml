import QtQuick 1.1

Rectangle {
    id:popup
    visible:false
    color:"transparent"
    anchors.fill:parent


    signal openPopupMenuFor(string menuName,variant target)
    signal closePopupMenu
    signal menuSelected(string menuItem)
    property string name
    property Item target
    property Item delegate


    onOpenPopupMenuFor: {
        if (menuName==name && delegate && target) {
            popup.target=target
            z=100
            var centerx=target.width/2
            var centery=target.height/2
            var P=mapFromItem(target,centerx,centery)

            delegate.x=P.x-delegate.width/2
            delegate.y=P.y-delegate.height/2
            if (delegate.x<0) delegate.x=0
            if (delegate.y<0) delegate.y=0
            visible=true
        }
    }

    onClosePopupMenu:
        visible=false

    onMenuSelected: {
        visible=false
        if (target && target.menuSelected)
            target.menuSelected(menuItem)
    }

    function connectMenuSelected(source,target) {
        if (source.menuSelected) {
            source.menuSelected.connect(target.menuSelected)
        }
        for(var i=0;i<source.children.length;i++) {
            connectMenuSelected(source.children[i],target)
        }
    }

    Component.onCompleted: {
        parent.openPopupMenuFor.connect(popup.openPopupMenuFor)
        parent.closePopupMenu.connect(popup.closePopupMenu)
        delegate.parent=popup
        connectMenuSelected(delegate,popup)

    }

    MouseArea {
        anchors.fill:parent
        onClicked: closePopupMenu()
    }
}
