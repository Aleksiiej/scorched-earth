import Felgo 4.0
import QtQuick 2.0


EntityBase
{
    id: groundBase
    entityType: "ground"
    height: 50
    
    anchors
    {
        left: parent.left
        right: parent.right
    }

    Rectangle
    {
        anchors.fill: parent
        color: "green"
    }
    
    BoxCollider
    {
        anchors.fill: parent
        bodyType: Body.Static
    }
}