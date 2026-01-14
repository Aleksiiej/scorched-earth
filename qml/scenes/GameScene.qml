import Felgo 4.0
import QtQuick 2.0
import "../common"
import "../entities"


SceneBase
{
    id: gameScene
    anchors.fill: parent

    signal backToMenuPressed

    property var player1: null
    property var player2: null

    property var player1Score: 0
    property var player2Score: 0
    property var playerNumber: 0
    property var bulletNumber: 0
    property var missileNumber: 0
    property var crateNumber: 0

    property var isEndgame: false
    property var isMultiplayer: false

    Keys.onPressed: (event) =>
    {
        if(player1 && (event.key == Qt.Key_Left
                   || event.key == Qt.Key_Right
                   || event.key == Qt.Key_Up
                   || event.key == Qt.Key_Down
                   || event.key == Qt.Key_Space))
        {
            player1.handleInput(event.key, true)
        }
        if(player2 && (event.key == Qt.Key_A
                   || event.key == Qt.Key_D
                   || event.key == Qt.Key_W
                   || event.key == Qt.Key_S
                   || event.key == Qt.Key_Control))
        {
            player2.handleInput(event.key, true)
        }
    }

    Keys.onReleased: (event) =>
    {
        if(player1 && (event.key == Qt.Key_Left
                   || event.key == Qt.Key_Right
                   || event.key == Qt.Key_Up
                   || event.key == Qt.Key_Down
                   || event.key == Qt.Key_Space))
        {
            player1.handleInput(event.key, false)
        }
        if(player2 && (event.key == Qt.Key_A
                   || event.key == Qt.Key_D
                   || event.key == Qt.Key_W
                   || event.key == Qt.Key_S
                   || event.key == Qt.Key_Control))
        {
            player2.handleInput(event.key, false)
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

    Loader
    {
        id: endGameLoader
        anchors.centerIn: parent
        source: isEndgame ? "../common/EndGame.qml" : ""
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

    Timer
    {
        id: crateTimer
        interval: Math.floor(Math.random() * 10000 + 5000)
        running: false
        repeat: true

        onTriggered:
        {
            spawnCrate()
        }
    }

    function shot(entityId)
    {
        var player = entityManager.getEntityById(entityId)
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

        if(player.entityId == player1.entityId)
        {
            statusBar1.reloadPlayer1()
        }
        else if(player.entityId == player2.entityId)
        {
            statusBar1.reloadPlayer2()
        }
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

    function spawnCrate()
    {
        var newCrateProperties =
        {
            x: Math.random() * gameWindow.width,
            y: 200,
            entityId: "crate_" + crateNumber,
            imageSource: "qrc:/scorched-earth/assets/img/crates/tanks_crateRepair.png"
        }
        crateNumber = crateNumber + 1
        entityManager.createEntityFromUrlWithProperties(
                      Qt.resolvedUrl("../entities/Crate.qml"),
                      newCrateProperties)
    }

    function prepareNewGame()
    {
        isEndgame = false
        player1Score = 0
        var newPlayerProperties = {
            x: parent.width / 2,
            y: parent.height - ground1.height - statusBar1.height - 40,
            entityId: "player_" + playerNumber
        }
        playerNumber = playerNumber + 1
        entityManager.createEntityFromUrlWithProperties(
                               Qt.resolvedUrl("../entities/Player.qml"),
                               newPlayerProperties)
        player1 = entityManager.getLastAddedEntity()

        if (isMultiplayer)
        {
            newPlayerProperties = {
                x: parent.width / 2 + 200,
                y: parent.height - ground1.height - statusBar1.height - 40,
                entityId: "player_" + playerNumber
            }
            playerNumber = playerNumber + 1
            entityManager.createEntityFromUrlWithProperties(
                               Qt.resolvedUrl("../entities/Player.qml"),
                               newPlayerProperties)
            player2 = entityManager.getLastAddedEntity()
        }

        resetTimers()
    }

    function resetTimers()
    {
        missileTimer.running = true
        crateTimer.running = true
    }

    function cleanupAfterGame()
    {
        entityManager.removeEntitiesByFilter(["tank",
                                              "projectile",
                                              "animation",
                                              "box"])
    }
}
