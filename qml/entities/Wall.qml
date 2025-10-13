import Felgo 4.0
import QtQuick 2.0


EntityBase
{
    id: wallBase
    entityType: "wall"
    opacity: 0
    width: 0
    height: 5

    BoxCollider
    {
        anchors.fill: parent
        bodyType: Body.Static
    }
}