import QtQuick 2.0
import Felgo 3.0

SnakePart {
    entityType: "snakebody"

    Rectangle {
        id: sprite
        width: 2
        height: 2
        color: "black"
    }

    x: parentPart.x + 1
    y: parentPart.y



}
