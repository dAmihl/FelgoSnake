import Felgo 3.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    activeScene: startscene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 960
    screenHeight: 640

    EntityManager {
        id: entityManager
        entityContainer: gamescene
    }

    StartScene{
        id: startscene
    }

    GameScene {
        id: gamescene
        visible: opacity > 0
    }

    // default state is start -> default scene is startscene
    state: "start"

   // state machine, takes care reversing the PropertyChanges when changing the state like changing the opacity back to 0
   states: [
     State {
       name: "start"
       PropertyChanges {target: startscene; opacity: 1}
       PropertyChanges {target: gameWindow; activeScene: startscene}
     },
     State {
       name: "game"
       PropertyChanges {target: gamescene; opacity: 1}
       PropertyChanges {target: gameWindow; activeScene: gamescene}
     }
   ]
}
