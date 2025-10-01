import QtQuick 2.0
import Felgo 4.0

EntityBase
{
    id: playerBase
    entityId: "player"
    entityType: "tank"
    x: parent.width / 2 - playerImage.width / 2
    y: parent.height / 2 - playerImage.height / 2

    Image
    {
        id: playerImage
        source: "qrc:/scorched-earth/assets/img/tankblue.png"
        width: 50
        height: 50
    }

    BoxCollider
    {
        id: playerCollider
        anchors.fill: playerImage
    }

    Keys.onPressed: function(event)
    {
        switch(event.key)
        {
            case Qt.Key_Left:
                playerCollider.force = Qt.point(-200, 0);
                break; 
            case Qt.Key_Right: 
                playerCollider.force = Qt.point(200, 0);
                break;
        }
    }

    Keys.onReleased: playerCollider.force = Qt.point(0, 0);
}