import QtQuick 2.0
import Felgo 4.0


GameWindow 
{
  id: gameWindow
  screenWidth: 1024
  screenHeight: 768
  title: "Scorched Earth"

  Scene 
  {
    id: scene
    width: gameWindow.screenWidth
    height: gameWindow.screenHeight
    anchors.fill: parent

    Rectangle
    {
      anchors.fill: parent
      color: "lightgrey"

      MainMenu
      {
        id: mainMenu
        anchors.centerIn: parent
      }
    }
  }
}