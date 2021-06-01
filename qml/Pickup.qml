import QtQuick 2.0
import Felgo 3.0

EntityBase {

    entityId: "entity"
    entityType: "customEntity"

    Rectangle {
        id: rect
        width: 4
        height: 4
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
        }
    }



}
