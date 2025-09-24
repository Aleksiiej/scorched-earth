import Felgo 4.0
import QtQuick 2.0
import "../common"


SceneBase
{
    id: gameScene

    property alias player: player

    Rectangle
    {
        id: gameArea

        anchors.fill: parent.gameWindowAnchorItem
        color: "red"

        Rectangle
        {
            id: player

            width: 50
            height: 50
            color: "blue"
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
    }
}