import QtQuick 2.0
import Felgo 3.0

EntityBase {

    property SnakePart parentPart
    property SnakePart next
    property int position
    property int sprite_offset: 8
    entityType: "snakepart"


    function followParent()
    {
        if (next)
        {
            next.followParent()
        }
        x = parentPart.x
        y = parentPart.y
    }


    Timer {
        interval: 3000
        running: false
        repeat: false
        onTriggered: {
            spawnNewPart()
        }
    }

    /**
      * Spawn new snake part and add to "list"
      */
    function spawnNewPart()
    {
        var new_part_props = {
            parentPart: this,
            position: this.position + 1,
            x: this.x + sprite.width,
            y: this.y
        }

        var res = entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("SnakeBody.qml"), new_part_props)
        next = entityManager.getEntityById(res)
        console.log("spawned new snake part from " + this + "at "+next.x+"/"+next.y)
    }

    /**
      *Spawn new part at last part of snake
      */
    function recSpawnNewPart()
    {
        if (next)
        {
            next.recSpawnNewPart()
        }else
        {
            spawnNewPart()
        }
    }
}
