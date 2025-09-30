import Felgo 4.0
import QtQuick 2.0
import "../common"


SceneBase
{
    id: gameScene

    property alias player: player
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

    Rectangle
    {
        id: gameArea

        anchors.fill: parent.gameWindowAnchorItem
        color: "blue"

        EntityBase
        {
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
                anchors.fill: playerImage
            }
        }

        EntityBase
        {
            id: "ground1"
            entityType: "ground"
            height: 20
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
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

        Rectangle
        {
            id: player

            width: 50
            height: 50
            color: "red"
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            Keys.onPressed:
            {

                if (event.key === Qt.Key_Left)
                {
                    x -= 10;
                } 
                else if (event.key === Qt.Key_Right)
                {
                    x += 10;;
                }
            }
        }

        GameButton
        {
            text: "Back to Menu"

            onClicked: backToMenuPressed()

            x: 50
            y: 50
        }
    }
}