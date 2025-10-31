import QtQuick 2.0
import Felgo 4.0
import "../animations"


EntityBase
{
    id: missileBase
    entityType: "projectile"
    transformOrigin: Item.Center

    Image
    {
        id: missileImg
        anchors.centerIn: parent
        opacity: 1
        source: "qrc:/scorched-earth/assets/img/projectiles/tank_bulletFly3.png"
    }

    Explosion
    {
        id: explosion
        anchors.centerIn: parent
    }

    BoxCollider
    {
        id: missileCollider
        anchors.fill: missileImg
        categories: Box.Category2

        Component.onCompleted:
        {
            var forwardVectorInBody = body.toWorldVector(Qt.point(0, 200))
            missileCollider.applyLinearImpulse(forwardVectorInBody, body.getWorldCenter())
        }

        fixture.onBeginContact: (other) =>
        {
            missileImg.opacity = 0
            missileCollider.body.linearVelocity = Qt.point(0, 0)
            missileCollider.body.angularVelocity = 0
            missileCollider.body.linearDamping = 100
            missileCollider.body.active = false
            var body = other.getBody()
            if(body.target.entityType == "tank")
            {
                body.target.handleGettingShot(100)
            }
            let tanks = getEntityArrayByType("tank")
            let distance = 0
            for(let tank of tanks)
            {
                distance = Math.sqrt(Math.pow(tank.x - parent.x, 2) + Math.pow(tank.y - parent.y, 2))
                if(distance < 100)
                {
                    tank.handleGettingShot(Math.floor(100 - distance))
                }
            }
            explosion.startExplosion()
        }
    }
}