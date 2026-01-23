import Felgo 4.0
import QtQuick 2.0
import QtQuick.Layouts


Rectangle
{
    id: statusBar
    height: 60
    color: "grey"

    property alias player1StatusBar: player1StatusBar
    property alias player2StatusBar: player2StatusBar

    anchors
    {
        bottom: parent.bottom
        left: parent.left
        right: parent.right
    }
    
    property int finalReloadProgress: 25

    RowLayout
    {
        anchors.fill: parent
    
        PlayerStatusBar
        {
            id: player1StatusBar
            title: "Player 1"
            playerNumber: 1
            playerRef: gameScene.player1
        }

        PlayerStatusBar
        {
            id: player2StatusBar
            title: "Player 2"
            playerNumber: 2
            playerRef: gameScene.player2
            opacity: gameScene.isMultiplayer ? 1 : 0
        }
    
        CommonButton
        {
            text: "Back to menu"

            onClicked:
            {
                backToMenuPressed()
                cleanupAfterGame()
            }
        }
    }
}   