import QtQuick 2.0
import Felgo 4.0
import "scenes"


GameWindow 
{
  id: gameWindow
  title: "Scorched Earth"
  
  width: 1024
  height: 768
  minimumWidth: width
  maximumWidth: width
  minimumHeight: height
  maximumHeight: height

  MenuScene
  {
    id: menuScene
    onStartGamePressed:
    {
      gameWindow.state = "game"
      gameScene.prepareNewGame()
    }
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
      PropertyChanges {target: menuScene; opacity: 1;}
      PropertyChanges {target: gameWindow; activeScene: menuScene}
    },
    State
    {
      name: "game"
      PropertyChanges {target: gameScene; opacity: 1;}
      PropertyChanges {target: gameWindow; activeScene: gameScene}
    }
  ]
}