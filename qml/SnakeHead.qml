import QtQuick 2.0
import Felgo 3.0

SnakePart {
    entityType: "snakehead"

    property int xDirection: 0
    property int yDirection: 0

    position: 0

    Rectangle {
        id: sprite
        width: 2
        height: 2
        color: "red"
    }

    BoxCollider {
        anchors.fill: sprite
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            moveForward()
        }
    }

    Timer{
        interval: 3000
        running:true
        repeat:true
        onTriggered: {
            changeDirection()
        }
    }

    function changeDirection()
    {
        if (yDirection == 0)
        {
            if (xDirection == -1)
            {
                xDirection = 0
                yDirection = 1
            }else if (xDirection == 1)
            {
                xDirection = 0
                yDirection = -1
            }
        }else if (xDirection == 0)
        {
            if (yDirection == -1)
            {
                yDirection = 0
                xDirection = -1
            }else if (yDirection == 1)
            {
                yDirection = 0
                xDirection = 1
            }
        }



    }

    Component.onCompleted: {
        spawnNewPart()
        if (next)
        {
            next.spawnNewPart()

            if (next.next)
            {
                next.next.spawnNewPart()
            }
        }
    }

    function moveForward()
    {
        if (next)
        {
            next.followParent()
        }

        x += xDirection
        y += yDirection

    }



}
