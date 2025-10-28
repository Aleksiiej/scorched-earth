import QtQuick 2.0
import Felgo 4.0
import "../animations"


EntityBase
{
    id: bulletBase
    entityType: "projectile"
    transformOrigin: Item.Center

    Image
    {
        id: bulletImg
        anchors.centerIn: parent
        opacity: 1
        source: "qrc:/scorched-earth/assets/img/tank_bulletFly1.png"
        rotation: Math.atan(bulletCollider.body.linearVelocity.y,
                            bulletCollider.body.linearVelocity.x) * 180 / Math.PI + 90
    }

    Explosion
    {
        id: explosion
        anchors.centerIn: parent
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
            bulletCollider.body.linearVelocity = Qt.point(0, 0)
            bulletCollider.body.angularVelocity = 0
            bulletCollider.body.linearDamping = 100
            bulletCollider.body.active = false
            var body = other.getBody()
            if(body.target.entityType == "tank")
            {
                body.target.handleGettingShot(100)
            }
            explosion.startExplosion()
        }
    }
}