import Felgo 4.0
import QtQuick 2.0
import QtQuick.Layouts
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

    ColumnLayout
    {
        anchors.centerIn: parent
        spacing: 20

        MenuButton
        {
            text: "StartGame"
            Layout.alignment: Qt.AlignHCenter
            
            onClicked: startGamePressed()
        }
        MenuButton
        {
            text: "Exit"
            Layout.alignment: Qt.AlignHCenter

            onClicked: Qt.quit()
        }
    }
}