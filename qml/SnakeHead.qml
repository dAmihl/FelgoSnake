import QtQuick 2.0
import Felgo 3.0

SnakePart {
    entityType: "snakehead"

    property int xDirection: 0
    property int yDirection: 0

    // was direction changed between last movement and now?
    property bool dirChanged: false

    property int minX: 0
    property int minY: 0
    property int maxX: 100
    property int maxY: 100

    position: 0

    Rectangle {
        id: sprite
        width: 4
        height: 4
        color: "red"
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
        moveTimer.start()
    }

    // pickup collider
    BoxCollider {
        anchors.fill: sprite
        collisionTestingOnlyMode: true
        categories: Box.Category1 // snake head
        collidesWith: Box.Category2 // Pickups
        fixture.onBeginContact: {
            console.log("Coll with pickup")
            eatanim.start()
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
            gamescene.gameOver()
        }
    }

    // Auto mover
    Timer {
        interval: 100
        id: moveTimer
        repeat: true
        onTriggered: {
            tickMoveForward()
        }
    }


    SequentialAnimation
    {
        id: eatanim

        NumberAnimation{
            target: sprite
            property: "scale"
            to: 1.5
            duration: 200
            easing.type: Easing.InOutCubic
        }

        NumberAnimation{
            target: sprite
            property: "scale"
            to: 1.0
            duration: 200
            easing.type: Easing.InOutCubic
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



    function moveForward()
    {
        if (next)
        {
            next.followParent()
        }

        x += xDirection * sprite.width
        y += yDirection * sprite.height

        // Screen wrap
        // origin of the snake part is in the top left corner of the rect
        // so we dont need to add the rect width/height to the minX/minY location since it is already aligned with the border
        if (x < minX)
        {
            x = maxX - sprite.width
        }else if (x > maxX - sprite.width)
        {
            x = minX
        }

        if (y < minY)
        {
            y = maxY - sprite.height
        }else if (y > maxY - sprite.height)
        {
            y = minY
        }

        dirChanged = false
    }

    function tickMoveForward()
    {
        moveForward()
    }

}
