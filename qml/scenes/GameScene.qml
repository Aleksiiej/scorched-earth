import Felgo 4.0
import QtQuick 2.0
import "../common"


SceneBase
{
    id: gameScene

    anchors.fill: parent
    Keys.forwardTo: player

    signal backToMenuPressed

    property alias player: player

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

    EntityBase
    {
        id: ground1
        entityType: "ground"
        height: 50
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
        id: sky
        color: "skyblue"

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: ground1.top
        }
    }
    
    EntityBase
    {
        id: player
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
        Keys.onPressed:
        {
            switch(event.key)
            {
                case Qt.Key_Left:
                    playerCollider.force = Qt.point(-200, 0);
                    break; 
                case Qt.Key_Right: 
                    playerCollider.force = Qt.point(200, 0);
                    break;
                case Qt.Key_Up:
                    break;
                case Qt.Key_Down:
                    break;
            }
        }
        Keys.onReleased: playerCollider.force = Qt.point(0, 0);
    }

    GameButton
    {
        text: "Back to Menu"
        onClicked: backToMenuPressed()
        x: 50
        y: 50
    }
}