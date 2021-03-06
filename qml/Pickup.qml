import QtQuick 2.0
import Felgo 3.0

EntityBase {
    entityType: "pickup"

    signal pickedUp(Pickup obj)

    Rectangle {
        id: rect
        width: 3
        height: 3
        color: "blue"
    }

    BoxCollider {
        anchors.fill: rect
        categories: Box.Category2 // Pickups
        collidesWith: Box.Category1 // snake head
        collisionTestingOnlyMode: true
        fixture.onBeginContact: {
            // Contact with snake SnakeHead
            // todo destroy self
            pickedUp(parent)
            removeEntity()
        }
    }



}
