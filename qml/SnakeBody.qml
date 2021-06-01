import QtQuick 2.0
import Felgo 3.0

SnakePart {
    entityType: "snakebody"

    Rectangle {
        id: sprite
        width: 4
        height: 4
        color: "black"
    }

    BoxCollider {
        anchors.fill: parent
        collisionTestingOnlyMode: true
        categories: Box.Category3 // Snake body
    }


}
