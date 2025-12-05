import Felgo 4.0
import QtQuick 2.0
import QtQuick.Layouts


ColumnLayout
{
    anchors.centerIn: parent

    Text
    {
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 25
        text: "You lost! Your score: " + gameScene.playerScore
    }
    
    RowLayout
    {
        CommonButton
        {
            text: "Restart game"
            onClicked:
            {
                gameScene.cleanupAfterGame()
                gameScene.prepareNewGame()
            }
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
