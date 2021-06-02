import QtQuick 2.0
import Felgo 3.0

SceneBase {

    id: startscene

    Text {
        text: "FelgoSnake"
        color: "blue"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 100
    }

    Text {
        text: "Press to play"
        color: "white"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.centerIn: parent
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            console.log("Start play")
            gameWindow.state = "game"
        }
    }

}
