import QtQuick 2.0
import Felgo 4.0
import "../../assets/img/animations"

EntityBase
{
    id: explosionAnimation
    entityType: "animation"

    property var images:
    [
        "../../assets/img/animations/tank_explosion5.png",
        "../../assets/img/animations/tank_explosion2.png",
        "../../assets/img/animations/tank_explosion3.png",
        "../../assets/img/animations/tank_explosion4.png",
        "../../assets/img/animations/tank_explosion8.png",
        "../../assets/img/animations/tank_explosion9.png",
    ]

    property var currentImage: 0

    Image
    {
        id: explosion
        source: images[currentImage]
        anchors.centerIn: parent
    }

    Timer
    {
        id: animationTimer
        interval: 250
        running: true
        repeat: true

        onTriggered:
        {
            if (currentImage < images.length)
            {
                currentImage = currentImage + 1
            }
        }
    }
}