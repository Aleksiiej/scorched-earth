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

    property var player1Keys: [
        Qt.Key_Left,
        Qt.Key_Right,
        Qt.Key_Up,
        Qt.Key_Down,
        Qt.Key_Space
    ]

    property var player2Keys: [
        Qt.Key_A,
        Qt.Key_D,
        Qt.Key_W,
        Qt.Key_S,
        Qt.Key_Control
    ]

    Keys.onPressed: (event) =>
    {
        if(player1 && player1Keys.includes(event.key))
        {
            player1.handleInput(event.key, true)
        }
        else if(player2 && player2Keys.includes(event.key))
        {
            player2.handleInput(event.key, true)
        }
    }

    Keys.onReleased: (event) =>
    {
        if(player1 && player1Keys.includes(event.key))
        {
            player1.handleInput(event.key, false)
        }
        else if(player2 && player2Keys.includes(event.key))
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
        
        anchors.bottom: statusBar.top
    }

    StatusBar
    {
        id: statusBar
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
            startSpeed: -1000,
            shooterId: player.entityId
        }
        bulletNumber++
        entityManager.createEntityFromUrlWithProperties(
                      Qt.resolvedUrl("../entities/Projectile.qml"),
                      newProjectileProperties)

        if(player.entityId == player1.entityId)
        {
            statusBar.reloadPlayer1()
        }
        else if(player.entityId == player2.entityId)
        {
            statusBar.reloadPlayer2()
        }
    }

    function increaseScore(entityId, amount)
    {
        if(entityId == player1.entityId)
        {
            player1Score += amount
        }
        else if(entityId == player2.entityId)
        {
            player2Score += amount
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
        missileNumber++
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
        crateNumber++
        entityManager.createEntityFromUrlWithProperties(
                      Qt.resolvedUrl("../entities/Crate.qml"),
                      newCrateProperties)
    }

    function prepareNewGame()
    {
        isEndgame = false
        player1Score = 0
        player2Score = 0
        var player1StartX = isMultiplayer ? parent.width / 3 : parent.width / 2
        var newPlayerProperties = {
            x: player1StartX,
            y: parent.height - ground1.height - statusBar.height - 40,
            entityId: "player_" + playerNumber
        }
        playerNumber++
        entityManager.createEntityFromUrlWithProperties(
                               Qt.resolvedUrl("../entities/Player.qml"),
                               newPlayerProperties)
        player1 = entityManager.getLastAddedEntity()

        if (isMultiplayer)
        {
            newPlayerProperties.x = parent.width * 2 / 3
            playerNumber++
            entityManager.createEntityFromUrlWithProperties(
                               Qt.resolvedUrl("../entities/Player.qml"),
                               newPlayerProperties)
            player2 = entityManager.getLastAddedEntity()
        }

        restartTimers()
    }

    function finishGame()
    {
        gameScene.isEndgame = true
        gameScene.stopTimers()
    }

    function disablePlayerControl()
    {
        let tanks = entityManager.getEntityArrayByType("tank")
        for(let tank of tanks)
        {
            tank.interactionEnabled = false
            tank.playerCollider.active = false
        }
    }

    function restartTimers()
    {
        missileTimer.restart()
        crateTimer.restart()
    }

    function stopTimers()
    {
        missileTimer.stop()
        crateTimer.stop()
    }

    function cleanupAfterGame()
    {
        entityManager.removeEntitiesByFilter(["tank",
                                              "projectile",
                                              "animation",
                                              "box"])
    }
}
