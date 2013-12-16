import QtQuick 1.1
Image {
    property int quality:-5
    source: qualityToIcon (quality)

    onQualityChanged: {
        source=qualityToIcon (quality)
    }

    function qualityToIcon(quality ) {
        switch (quality) {
        case -2:
            return "img/l_K1.png"
            break
        case -1:
            return "img/l_K2.png"
            break
        case 0:
            return "img/l_K3.png"
            break
        case 1:
            return "img/l_K5.png"
            break
        case 2:
            return "img/l_K6.png"
            break
        default:
            return "img/l_K4.png"
        }
    }
}
