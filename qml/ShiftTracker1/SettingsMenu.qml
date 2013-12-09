import QtQuick 1.1

HorizontalMenu {
    signal goBackPressed
    HorizontalMenuItem {
        text:"Back"
        onHorizontalMenuItemClicked: goBackPressed()
    }


}
