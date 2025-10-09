import QtQuick 2.0
import Felgo 4.0

EntityBase
{
    id: bulletBase
    entityId: "bullet"
    entityType: "projectile"

    Image
    {
        id: bulletImg
        source: "qrc:/scorched-earth/assets/img/tank_bulletFly1.png"
        transformOrigin: Item.Bottom
    }
}