import QtQuick 2.0
import Felgo 4.0
import "../animations"

EntityBase
{
    id: crateBase
    entityType: "box"
    property var imageSource: ""

    Image
    {
        id: crateImage
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
        id: crateCollider
        anchors.fill: crateImage
        categories: Box.Category3

        fixture.onBeginContact: (other) =>
        {
            var body = other.getBody()
            if(body.target.entityType == "projectile")
            {
                crateImage.opacity = 0
                crateCollider.body.linearVelocity = Qt.point(0, 0)
                crateCollider.body.angularVelocity = 0
                crateCollider.body.linearDamping = 100
                crateCollider.body.active = false
                explosion.startExplosion()
            }
            if(body.target.entityType == "tank")
            {
                body.target.hpAmount = 100
                entityManager.removeEntityById(entityId)
            }
        }
    }
}