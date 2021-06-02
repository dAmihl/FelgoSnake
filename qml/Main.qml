import Felgo 3.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    activeScene: scene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 960
    screenHeight: 640

    EntityManager {
        id: entityManager
        entityContainer: scene
    }


    Scene {
        id: scene

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 240
        height: 120

        property int currentScore: 0

        PhysicsWorld{
            debugDrawVisible: true
            z: 1000
        }

        Rectangle{
            id: background
            anchors.fill: scene
            color: "white"
        }

        Rectangle
        {
            id: score
            anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
            anchors.top: scene.gameWindowAnchorItem.top
            color: "black"
            width: 30
            height: 10

            Text{
                text: "Score " + scene.currentScore
                color:"white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                font.pixelSize: 8
            }
        }

        SnakeHead {
            id: snake
            xDirection: -1
            x: scene.width / 2
            y: scene.height/2
            minX: 0
            maxX: scene.width
            minY: 0
            maxY: scene.height
        }

        PickupSpawner {
            minX: 16
            maxX: scene.width-16
            minY: 16
            maxY: scene.height-16
            onScoreIncrease: {
                scene.currentScore++
            }
        }

        Keys.onUpPressed: {
            snake.changeDirectionTo(0, -1)
        }

        Keys.onDownPressed: {
            snake.changeDirectionTo(0, 1)
        }

        Keys.onRightPressed: {
            snake.changeDirectionTo(1, 0)
        }

        Keys.onLeftPressed: {
            snake.changeDirectionTo(-1, 0)
        }

    }
}
