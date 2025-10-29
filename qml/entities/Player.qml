import QtQuick 2.0
import Felgo 4.0
import "../animations"


EntityBase
{
    id: playerBase
    entityId: "player"
    entityType: "tank"

    property var keys: ({})
    property var isReloaded: true
    property int hpAmount: 100
    property bool interactionEnabled: true

    property alias tankTurretImg: tankTurretImg
    property alias tankBodyImg: tankBodyImg

    Image
    {
        id: tankTurretImg
        source: "qrc:/scorched-earth/assets/img/player/tanks_turret1.png"
        anchors.bottom: tankBodyImg.top
        anchors.bottomMargin: -10
        anchors.horizontalCenter: tankBodyImg.horizontalCenter
        transformOrigin: Item.Bottom
        rotation: 0
    }

    Image
    {
        id: tankTracksImg
        source: "qrc:/scorched-earth/assets/img/player/tanks_tankTracks3.png"
        anchors.verticalCenter: tankBodyImg.bottom
        anchors.horizontalCenter: tankBodyImg.horizontalCenter
    }

    Image
    {
        id: tankBodyImg
        source: "qrc:/scorched-earth/assets/img/player/tanks_tankGreen_body3.png"
    }

    Explosion
    {
        id: explosion
        anchors.centerIn: parent
    }

    BoxCollider
    {
        id: playerCollider
        anchors.fill: tankTracksImg
    }

    Timer
    {
        id: movementTimer
        interval: 16
        running: true
        repeat: true
        
        onTriggered:
        {
            if(interactionEnabled)
            {
                if (keys[Qt.Key_Left] && playerCollider.linearVelocity.x > -250)
                {
                    playerCollider.force = Qt.point(-200, 0)
                }
                else if (keys[Qt.Key_Right] && playerCollider.linearVelocity.x < 250)
                {
                    playerCollider.force = Qt.point(200, 0)
                }
                else
                {
                    playerCollider.force = Qt.point(0, 0)
                }

                if (keys[Qt.Key_Up] && tankTurretImg.rotation < 100)
                {
                    tankTurretImg.rotation += 4
                }
                if (keys[Qt.Key_Down] && tankTurretImg.rotation > -100)
                {
                    tankTurretImg.rotation -= 4
                }

                if (keys[Qt.Key_Space] && isReloaded)
                {
                    handleShot()
                }
            }
        }
    }

    Timer
    {
        id: reloadTimer
        interval: 1000
        running: false

        onTriggered:
        {
            isReloaded = true
            running = false
        }
    }

    function handleShot()
    {
        if(interactionEnabled)
        {
            parent.shot()
            isReloaded = false
            reloadTimer.running = true
        }
    }

    function handleGettingShot(hpDamage)
    {
        hpAmount = hpAmount - hpDamage
        if(hpAmount >= 0)
        {
            tankTurretImg.opacity = 0
            tankBodyImg.opacity = 0
            tankTracksImg.opacity = 0
            playerCollider.body.linearVelocity = Qt.point(0, 0)
            playerCollider.body.angularVelocity = 0
            playerCollider.body.linearDamping = 100
            playerCollider.body.active = false
            interactionEnabled = false
            explosion.startExplosion()
        }
    }

    function handleInput(key, pressed)
    {
        keys[key] = pressed
    }
}