import QtQuick 2.0
import Felgo 4.0

EntityBase
{
    id: bulletBase
    entityType: "projectile"
    transformOrigin: Item.Top

    // Component.onCompleted:
    // {
    //     Qt.callLater(function()
    //     {
    //         var forwardVectorInBody = bulletCollider.body.toWorldVector(Qt.point(10, 0))
    //         bulletCollider.applyLinearImpulse(forwardVectorInBody, bulletCollider.getWorldCenter())
    //     })
    // }

    Image
    {
        id: bulletImg
        source: "qrc:/scorched-earth/assets/img/tank_bulletFly1.png"
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