import QtQuick 2.0
import Felgo 4.0
import "scenes"


GameWindow 
{
  id: gameWindow
  screenWidth: 1024
  screenHeight: 768
  title: "Scorched Earth"

  EntityManager
  {
    id: entityManager
    entityContainer: gameScene
  }

  MenuScene
  {
    id: menuScene

    onStartGamePressed: gameWindow.state = "game"
  }

  GameScene
  {
    id: gameScene

    onBackToMenuPressed: gameWindow.state = "menu"
  }

  state: "menu"
  
  states:
  [
    State
    {
      name: "menu"
      PropertyChanges {target: menuScene; opacity: 1}
      PropertyChanges {target: gameWindow; activeScene: menuScene}
    },

    State
    {
      name: "game"
      PropertyChanges {target: gameScene; opacity: 1}
      PropertyChanges {target: gameWindow; activeScene: gameScene}
      StateChangeScript
      {
        script:
        {
          Qt.callLater(function()
          {
            gameScene.player.forceActiveFocus();
          });
        }
      } 
    }
  ]
}