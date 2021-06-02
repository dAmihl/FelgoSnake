import QtQuick 2.0
import Felgo 3.0

// EMPTY SCENE

SceneBase {

    id: gamescene
    // the filename of the current level gets stored here, it is used for loading the
    property string activeLevelFileName
    // the currently loaded level gets stored here
    property variant activeLevel

    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 240
    height: 120

    property int currentScore: 0

    // set the name of the current level, this will cause the Loader to load the corresponding level
    function setLevel(fileName) {
      activeLevelFileName = fileName
    }

    Keys.onUpPressed: {
        activeLevel.changeSnakeDirection(0, -1)
    }

    Keys.onDownPressed: {
        activeLevel.changeSnakeDirection(0, 1)
    }

    Keys.onRightPressed: {
        activeLevel.changeSnakeDirection(1, 0)
    }

    Keys.onLeftPressed: {
        activeLevel.changeSnakeDirection(-1, 0)
    }



    // load levels at runtime
    Loader {
     id: loader
     source: activeLevelFileName !== "" ? activeLevelFileName : ""
     onLoaded: {
        currentScore = 0
        // since we did not define a width and height in the level item itself, we are doing it here
        item.width = gamescene.width
        item.height = gamescene.height
        // store the loaded level as activeLevel for easier access
        activeLevel = item
        }
    }

}
