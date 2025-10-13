import QtQuick 2.0
import Felgo 4.0

EntityBase
{
    id: bulletBase
    entityType: "projectile"
    transformOrigin: Item.Center

    Image
    {
        id: bulletImg
        anchors.centerIn: parent
        source: "qrc:/scorched-earth/assets/img/tank_bulletFly1.png"
        rotation: Math.atan2(bulletCollider.body.linearVelocity.y,
                             bulletCollider.body.linearVelocity.x) * 180 / Math.PI + 90
    }

    BoxCollider
    {
        id: bulletCollider
        anchors.fill: bulletImg

        Component.onCompleted:
        {
            var forwardVectorInBody = body.toWorldVector(Qt.point(0, -1000))
            bulletCollider.applyLinearImpulse(forwardVectorInBody, body.getWorldCenter())
        }
    }
}