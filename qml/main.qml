import QtQuick 2.0
import Felgo 4.0
import "scenes"


GameWindow 
{
  id: gameWindow
  title: "Scorched Earth"
  
  width: 1500
  height: 1000
  minimumWidth: width
  maximumWidth: width
  minimumHeight: height
  maximumHeight: height

  EntityManager
  {
    id: entityManager
    entityContainer: gameScene
  }

  MenuScene
  {
    id: menuScene
    onStartGamePressed:
    {
      gameWindow.state = "singlePlayer"
      gameScene.prepareNewGame()
    }
    onStartLocalMultiplayerGamePressed:
    {
      gameWindow.state = "localMultiplayer"
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
      PropertyChanges {target: menuScene; opacity: 1}
      PropertyChanges {target: gameWindow; activeScene: menuScene}
    },
    State
    {
      name: "singlePlayer"
      PropertyChanges {target: gameScene; opacity: 1; isMultiplayer: false}
      PropertyChanges {target: gameWindow; activeScene: gameScene}
    },
    State
    {
      name: "localMultiplayer"
      PropertyChanges {target: gameScene; opacity: 1; isMultiplayer: true}
      PropertyChanges {target: gameWindow; activeScene: gameScene}
    }
  ]
}