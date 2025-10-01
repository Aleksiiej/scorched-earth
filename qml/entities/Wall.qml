import Felgo 4.0
import QtQuick 2.0


EntityBase
{
    id: wallBase
    entityType: "wall"
    opacity: 0
    width: 0
    height: parent.height

    BoxCollider
    {
        anchors.fill: parent
        bodyType: Body.Static
    }
}