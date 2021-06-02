import QtQuick 2.0
import Felgo 3.0

Item {

    id: snakelevel

    EntityManager {
        id: entityManager
        entityContainer: snakelevel
    }

    PhysicsWorld{
        debugDrawVisible: true
        z: 1000
    }

    Rectangle{
        id: background
        anchors.fill: parent
        color: "white"
    }

    Rectangle
    {
        id: score
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
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

    function changeSnakeDirection(x, y)
    {
        snake.changeDirectionTo(x,y)
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

}
