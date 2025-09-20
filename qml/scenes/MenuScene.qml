import Felgo 4.0
import QtQuick 2.0
import "../common"


SceneBase
{
    id: menuScene

    signal startGamePressed

    Rectangle
    {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#47688e"
    }

    Text
    {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 30
        font.pixelSize: 30
        color: "#e9e9e9"
        text: "Scorched Earth"
    }

    Column
    {
        anchors.centerIn: parent

        MenuButton
        {
            text: "StartGame"
            onClicked: startGamePressed()
        }
        MenuButton
        {
            text: "Exit"
            onClicked: Qt.quit()
        }
    }
}