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
        id: world
        running: true
        gravity.y: 9.81
        z: 10

        updatesPerSecondForPhysics: 60
        velocityIterations: 5
        positionIterations: 5

        debugDrawVisible: false
    }

    Ground
    {
        id: ground1
    }
    
    Rectangle
    {
        id: sky
        color: "skyblue"
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: ground1.top
        }
    }

    Wall
    {
        id: leftWall
        anchors.left: parent.left
    }

    Wall
    {
        id: rightWall
        anchors.right: parent.right
    }

    GameButton
    {
        text: "Back to Menu"
        onClicked:
        {
            backToMenuPressed()
            cleanupAfterGame()
        }
        x: 50
        y: 50
    }

    function shot()
    {
        var turretCenter = player.mapToItem(null,
                                            player.tankBodyImg.width/2,
                                            -player.tankBodyImg.height)
        var newBulletProperties =
        {
            x: turretCenter.x,
            y: turretCenter.y,
            rotation: player.tankTurretImg.rotation
        }
        entityManager.createEntityFromUrlWithProperties(
                      Qt.resolvedUrl("../entities/Bullet.qml"),
                      newBulletProperties)
    }

    function prepareNewGame()
    {
        var newPlayerProperties = {
            x: parent.width / 2,
            y: parent.height - ground1.height - 40
        }
        entityManager.createEntityFromUrlWithProperties(
                               Qt.resolvedUrl("../entities/Player.qml"),
                               newPlayerProperties)
        player = entityManager.getLastAddedEntity()
    }

    function cleanupAfterGame()
    {
        entityManager.removeEntitiesByFilter(["tank", "projectile"])
    }
}
