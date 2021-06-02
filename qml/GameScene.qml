import QtQuick 2.0
import Felgo 3.0

// EMPTY SCENE

SceneBase {

    id: gamescene

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
        anchors.fill: gamescene
        color: "white"
    }

    Rectangle
    {
        id: score
        anchors.horizontalCenter: gamescene.gameWindowAnchorItem.horizontalCenter
        anchors.top: gamescene.gameWindowAnchorItem.top
        color: "black"
        width: 30
        height: 10

        Text{
            text: "Score " + gamescene.currentScore
            color:"white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            font.pixelSize: 8
        }
    }

    SnakeHead {
        id: snake
        xDirection: -1
        x: gamescene.width / 2
        y: gamescene.height/2
        minX: 0
        maxX: gamescene.width
        minY: 0
        maxY: gamescene.height
    }

    PickupSpawner {
        minX: 16
        maxX: gamescene.width-16
        minY: 16
        maxY: gamescene.height-16
        onScoreIncrease: {
            gamescene.currentScore++
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
