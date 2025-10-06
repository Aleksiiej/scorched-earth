import Felgo 4.0
import QtQuick 2.0
import "../common"
import "../entities"


SceneBase
{
    id: gameScene
    anchors.fill: parent

    property alias player1: player1
    
    Keys.forwardTo: player1

    signal backToMenuPressed

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

    Player
    {
        id: player1
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
        onClicked: backToMenuPressed()
        x: 50
        y: 50
    }

    function resetGame()
    {
        player1.x = parent.width / 2
        player1.y = parent.height / 2
        player1.movementTimer.running = true
    }
}