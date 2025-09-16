import QtQuick
import QtQuick.Controls

Window {
    id: root
    visible: true
    width: 640
    height: 480
    color: "lightblue"
    title: qsTr("Scorched Earth")

    Loader {
        id: mainLoader
        anchors.fill: parent
    }

    Column {
        id: mainColumn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20

        Button{
            id: startButton
            text: "Start Game"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                console.log("Game Started")
                mainColumn.visible = false
                mainLoader.source = "gameStage.qml"
            }
        }

        Button{
            id: exitButton
            text: "Exit"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                Qt.quit()
            }
        }
    }
}   