import Felgo 4.0
import QtQuick 2.0
import "../common"
import "../entities"


SceneBase
{
    id: gameScene
    anchors.fill: parent

    signal backToMenuPressed

    property var player: null
    property var bulletNumber: 0
    property var missileNumber: 0

    Keys.onPressed: (event) =>
    {
        if(player)
        {
            player.handleInput(event.key, true)
        }
    }

    Keys.onReleased: (event) =>
    {
        if(player)
        {
            player.handleInput(event.key, false)
        }
    }

    PhysicsWorld
    {
        running: true
        gravity.y: 9.81
        z: 10

        updatesPerSecondForPhysics: 60
        velocityIterations: 5
        positionIterations: 5

        debugDrawVisible: false
    }

    Sky
    {
        anchors.bottom: ground1.top
    }

    Ground
    {
        id: ground1
        
        anchors.bottom: statusBar1.top
    }

    StatusBar
    {
        id: statusBar1
    }

    Wall
    {
        id: leftWall

        anchors.right: ground1.left
        anchors.bottom: ground1.top
    }

    Wall
    {
        id: rightWall

        anchors.left: ground1.right
        anchors.bottom: ground1.top
    }

    Timer
    {
        id: missileTimer
        interval: 1000
        running: false
        repeat: true

        onTriggered:
        {
            spawnMissile()
        }
    }

    function shot()
    {
        var turretCenter = player.mapToItem(null,
                                            player.tankBodyImg.width/2,
                                            -player.tankBodyImg.height)
        var newProjectileProperties =
        {
            x: turretCenter.x,
            y: turretCenter.y,
            rotation: player.tankTurretImg.rotation,
            entityId: "bullet_" + bulletNumber,
            imageSource: "qrc:/scorched-earth/assets/img/projectiles/tank_bulletFly1.png",
            startSpeed: -1000
        }
        bulletNumber = bulletNumber + 1
        entityManager.createEntityFromUrlWithProperties(
                      Qt.resolvedUrl("../entities/Projectile.qml"),
                      newProjectileProperties)
        statusBar1.reload()
    }

    function spawnMissile()
    {
        var newProjectileProperties =
        {
            x: Math.random() * gameWindow.width,
            y: 0,
            rotation: -45 + Math.random() * 90,
            entityId: "missile_" + missileNumber,
            imageSource: "qrc:/scorched-earth/assets/img/projectiles/tank_bulletFly3.png",
            startSpeed: 200
        }
        missileNumber = missileNumber + 1
        entityManager.createEntityFromUrlWithProperties(
                      Qt.resolvedUrl("../entities/Projectile.qml"),
                      newProjectileProperties)
    }

    function prepareNewGame()
    {
        var newPlayerProperties = {
            x: parent.width / 2,
            y: parent.height - ground1.height - statusBar1.height - 40
        }
        entityManager.createEntityFromUrlWithProperties(
                               Qt.resolvedUrl("../entities/Player.qml"),
                               newPlayerProperties)
        player = entityManager.getLastAddedEntity()
        missileTimer.running = true
    }

    function cleanupAfterGame()
    {
        entityManager.removeEntitiesByFilter(["tank", "projectile", "animation"])
    }
}
