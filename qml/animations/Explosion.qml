import QtQuick 2.0
import Felgo 4.0


Item
{
    id: explosion
    opacity: 0

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
        id: explosionImg
        source: images[currentImage]
        anchors.centerIn: parent
    }

    Timer
    {
        id: animationTimer
        interval: 250
        running: false
        repeat: true

        onTriggered:
        {
            if (currentImage < images.length - 1)
            {
                currentImage = currentImage + 1
            }
            else
            {
                entityManager.removeEntityById(explosion.parent.entityId)
            }
        }
    }

    function startExplosion()
    {
        opacity = 1
        animationTimer.running = true
    }
}