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
        text: "You lost! Your score: " + playerScore
    }

    RowLayout
    {
        CommonButton
        {
            text: "Restart game"
            onClicked:
            {
                cleanupAfterGame()
                prepareNewGame()
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
