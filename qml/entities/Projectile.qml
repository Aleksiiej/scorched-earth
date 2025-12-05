import QtQuick 2.0
import Felgo 4.0
import "../animations"


EntityBase
{
    id: projectileBase
    entityType: "projectile"
    transformOrigin: Item.Center

    property var imageSource: ""
    property var startSpeed: 0

    Image
    {
        id: missileImg
        anchors.centerIn: parent
        opacity: 1
        source: imageSource
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
            var forwardVectorInBody = body.toWorldVector(Qt.point(0, startSpeed))
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
            if(body.target.entityType == "projectile")
            {
                gameScene.playerScore += 10
            }
            let tanks = getEntityArrayByType("tank")
            let distance = 0
            for(let tank of tanks)
            {
                distance = Math.sqrt(Math.pow(tank.centerX - parent.x, 2) + Math.pow(tank.centerY - parent.y, 2))
                if(distance < 100)
                {
                    tank.handleGettingShot(Math.floor(120 - distance))
                }
            }
            explosion.startExplosion()
        }
    }
}