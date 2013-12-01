import QtQuick 1.1

Grid {
    id: kartmenu

    width: 65*3
    height: 65*3
    rows: 3
    columns: 3

    KartBack {id: kartSlow; quality:-1}
    KartBack {id: kartNeutral; quality: 0}
    KartBack {id: kartFast; quality:1}
    KartBack {id: kartTrash; quality: -2}
    Rectangle{width:65;height:65; visible: true;color:"transparent"}

    KartBack {id: kartRocket; quality:2}

    Image {
        id: repair
        source: "img/tool2.png"
    }
    KartBack {id: kartUnknown ; quality: -5}

}
