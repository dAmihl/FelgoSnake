import QtQuick 2.0
import Felgo 3.0

EntityBase {

    entityId: "pickupspawner"
    entityType: "pickupspawner"

    property int minX: 0
    property int maxX: 100
    property int minY: 0
    property int maxY: 100

    signal scoreIncrease(int amount)

    Component.onCompleted: {
        spawnPickup()
    }

    function spawnPickup()
    {
        var new_part_props = {
            x = minX + Math.floor(Math.random()*maxX),
            y = minY + Math.floor(Math.random()*maxY),
        }

        var res = entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Pickup.qml"), new_part_props)
        var pu = entityManager.getEntityById(res)
        pu.pickedUp.connect(onPickupGet)
        console.log("spawned new pickup at "+pu.x+"/"+pu.y)
    }

    function onPickupGet(pickup)
    {
        console.log("Player picked up "+pickup)
        scoreIncrease(1)
        spawnPickup()
    }

}
