import QtQuick 2.0
import Felgo 3.0

SnakePart {
    entityType: "snakehead"

    property int xDirection: 0
    property int yDirection: 0

    // was direction changed between last movement and now?
    property bool dirChanged: false

    position: 0

    Rectangle {
        id: sprite
        width: 4
        height: 4
        color: "red"
    }

    // pickup collider
    BoxCollider {
        anchors.fill: parent
        collisionTestingOnlyMode: true
        categories: Box.Category1 // snake head
        collidesWith: Box.Category2 // Pickups
        fixture.onBeginContact: {
            console.log("Coll with pickup")
            recSpawnNewPart()
        }
    }

    // Snakebody collider
    BoxCollider {
        anchors.fill: parent
        collisionTestingOnlyMode: true
        categories: Box.Category1 // snake head
        collidesWith: Box.Category3 // snake body parts
        fixture.onBeginContact: {
            console.log("Colided with body. Gameover!")
        }
    }

    // Auto mover
    Timer {
        interval: 100
        id: moveTimer
        running: true
        repeat: true
        onTriggered: {
            tickMoveForward()
        }
    }


    function changeDirectionTo(x, y)
    {
        if (dirChanged){
            // dir already changed, wait for next moveForward()
            return
        }

        if (x !== 0 && y === 0 && xDirection == 0)
        {
            xDirection = x
            yDirection = y

            dirChanged = true
            moveForward() // more responsive turns
            moveTimer.restart()
        }

        if (y !== 0 && x === 0 && yDirection == 0)
        {
           yDirection = y
           xDirection = x

            dirChanged = true
            moveForward() // more responsive turns
            moveTimer.restart()
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

        x += xDirection * sprite.width
        y += yDirection * sprite.height
        dirChanged = false
    }

    function tickMoveForward()
    {
        moveForward()
    }

}
