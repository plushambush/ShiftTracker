import QtQuick 1.1

Rectangle {
    id:popup
    visible:false
    color:"transparent"
    anchors.fill:parent

    property string name
    property Item target
    property variant tag
    property Item delegate
    property Item receiver

    signal openPopupMenuFor(variant target,string menuName,variant tag,variant receiver)
    signal closePopupMenu
    signal menuItemSelected(string menuItem)
    signal menuSelected(string menuName,string menuItem,variant tag)




    onOpenPopupMenuFor: {
        if (menuName==name && delegate && target) {
            popup.tag=tag
            popup.target=target
            popup.receiver=receiver
            z=100
            var centerx=target.width/2
            var centery=target.height/2
            var P=delegate.mapFromItem(target,centerx,centery)

            delegate.x+=P.x-delegate.width/2
            delegate.y+=P.y-delegate.height/2

            var offx=delegate.x+delegate.width-width
            var offy=delegate.y+delegate.height-height
            if (offx>0) delegate.x-=offx
            if (offy>0) delegate.y-=offy
            if (delegate.x<0) delegate.x=0
            if (delegate.y<0) delegate.y=0

            visible=true
        }
    }

    onClosePopupMenu:
        visible=false

    onMenuItemSelected: {
        visible=false
        if (receiver)
            receiver.menuSelected(name,menuItem,tag)
        else
            menuSelected(name,menuItem,tag)
    }

    function connectMenuItemSelected(source,target) {
        if (source.menuItemSelected) {
            source.menuItemSelected.connect(target.menuItemSelected)
        }
        for(var i=0;i<source.children.length;i++) {
            connectMenuItemSelected(source.children[i],target)
        }
    }

    Component.onCompleted: {
        parent.openPopupMenuFor.connect(popup.openPopupMenuFor)
        parent.closePopupMenu.connect(popup.closePopupMenu)
        delegate.parent=popup
        connectMenuItemSelected(delegate,popup)

    }

    MouseArea {
        anchors.fill:parent
        onClicked: closePopupMenu()
    }
}
