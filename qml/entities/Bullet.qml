import QtQuick 2.0
import Felgo 4.0

EntityBase
{
    id: bulletBase
    entityType: "projectile"
    transformOrigin: Item.Center

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
        id: bulletImg
        anchors.centerIn: parent
        opacity: 1
        source: "qrc:/scorched-earth/assets/img/tank_bulletFly1.png"
        rotation: Math.atan(bulletCollider.body.linearVelocity.y,
                            bulletCollider.body.linearVelocity.x) * 180 / Math.PI + 90
    }

    BoxCollider
    {
        id: bulletCollider
        anchors.fill: bulletImg
        categories: Box.Category2

        Component.onCompleted:
        {
            var forwardVectorInBody = body.toWorldVector(Qt.point(0, -1000))
            bulletCollider.applyLinearImpulse(forwardVectorInBody, body.getWorldCenter())
        }

        fixture.onBeginContact: (other) =>
        {
            bulletImg.opacity = 0
            explosionImg.opacity = 1
            animationTimer.running = true
            bulletCollider.body.linearVelocity = Qt.point(0, 0)
            bulletCollider.body.angularVelocity = 0
            bulletCollider.body.linearDamping = 100
            bulletCollider.body.active = false
            var body = other.getBody()
            if(body.target.entityType == "tank")
            {
                console.log("HIT!")
                body.target.handleGettingShot(100)
            }
        }
    }

    Image
    {
        id: explosionImg
        source: images[currentImage]
        anchors.centerIn: parent
        opacity: 0
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
                entityManager.removeEntityById(entityId)
            }
        }
    }
}