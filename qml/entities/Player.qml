import QtQuick 2.0
import Felgo 4.0

EntityBase
{
    id: playerBase
    entityId: "player"
    entityType: "tank"

    property bool leftPressed: false
    property bool rightPressed: false
    property bool upPressed: false
    property bool downPressed: false
    property bool spacePressed: false

    property alias tankTurretImg: tankTurretImg
    property alias tankBodyImg: tankBodyImg

    signal shot()

    Image
    {
        id: tankTurretImg
        source: "qrc:/scorched-earth/assets/img/tanks_turret1.png"
        anchors.bottom: tankBodyImg.top
        anchors.bottomMargin: -10
        anchors.horizontalCenter: tankBodyImg.horizontalCenter
        transformOrigin: Item.Bottom
    }

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
                leftPressed = true
                break
            case Qt.Key_Right:
                rightPressed = true
                break
            case Qt.Key_Up:
                upPressed = true
                break
            case Qt.Key_Down:
                downPressed = true
                break
            case Qt.Key_Space:
                spacePressed = true
                break
        }
    }

    Keys.onReleased: function(event)
    {
        switch(event.key)
        {
            case Qt.Key_Left:
                leftPressed = false
                break
            case Qt.Key_Right:
                rightPressed = false
                break
            case Qt.Key_Up:
                upPressed = false
                break
            case Qt.Key_Down:
                downPressed = false
                break
        }
    }

    Timer
    {
        id: movementTimer
        interval: 16
        running: false
        repeat: true
        
        onTriggered:
        {
            if(leftPressed && playerCollider.linearVelocity.x > -250)
            {
                playerCollider.force = Qt.point(-200, 0)
            }
            else if(rightPressed && playerCollider.linearVelocity.x < 250)
            {
                playerCollider.force = Qt.point(200, 0)
            }
            else
            {
                playerCollider.force = Qt.point(0, 0)
            }

            if(upPressed && tankTurretImg.rotation < 100)
            {
                tankTurretImg.rotation += 4
            }
            if(downPressed && tankTurretImg.rotation > -100)
            {
                tankTurretImg.rotation -= 4
            }
            if(spacePressed)
            {
                spacePressed = false
                playerBase.shot()
            }
        }
    }

    function resetPlayer(groundHeight)
    {
        x = parent.width / 2
        y = parent.height - groundHeight - tankTracksImg.height
        tankTurretImg.rotation = 0
        playerCollider.linearVelocity = Qt.point(0, 0)
        movementTimer.running = true
    }
}