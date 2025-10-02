import QtQuick 2.0
import Felgo 4.0

EntityBase
{
    id: playerBase
    entityId: "player"
    entityType: "tank"
    x: parent.width / 2
    y: parent.height / 2

    Image
    {
        id: tankTracksImg
        source: "qrc:/scorched-earth/assets/img/tanks_tankTracks3.png"
        anchors.verticalCenter: tankBodyImg.bottom
        anchors.horizontalCenter: tankBodyImg.horizontalCenter
    }

    Image
    {
        id: tankBodyImg
        source: "qrc:/scorched-earth/assets/img/tanks_tankGreen_body3.png"
    }

    Image
    {
        id: tankTurretImg
        source: "qrc:/scorched-earth/assets/img/tanks_turret1.png"
        anchors.bottom: tankBodyImg.verticalCenter
        anchors.horizontalCenter: tankBodyImg.horizontalCenter
    }

    BoxCollider
    {
        id: playerCollider
        anchors.fill: tankTracksImg
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