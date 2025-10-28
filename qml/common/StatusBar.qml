import Felgo 4.0
import QtQuick 2.0
import QtQuick.Layouts


Rectangle
{
    id: statusBar
    height: 60
    color: "grey"
    anchors
    {
        bottom: parent.bottom
        left: parent.left
        right: parent.right
    }
    
    property int finalReloadProgress: 25

    RowLayout
    {
        spacing: 20

        ColumnLayout
        {
            width: 200

            Text
            {
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 20
                text: "Reload"
            }

            Rectangle
            {
                Layout.alignment: Qt.AlignHCenter
                color: "red"
                width: parent.width
                height: 20

                Rectangle
                {
                    anchors.left: parent.left
                    width: reloadBarTimer.reloadProgress * (parent.width / statusBar.finalReloadProgress)
                    height: parent.height
                    color: "green"
                }
            }
        }

        ColumnLayout
        {
            width: 200

            Text
            {
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 20
                text: "Hit Points"
            }

            Rectangle
            {
                Layout.alignment: Qt.AlignHCenter
                color: "red"
                width: parent.width
                height: 20

                Rectangle
                {
                    anchors.left: parent.left
                    width: gameScene.player ? gameScene.player.hpAmount * (parent.width / 100) : 0
                    height: parent.height
                    color: "green"
                }
            }
        }

        GameButton
        {
            text: "Back to menu"
            onClicked:
            {
                backToMenuPressed()
                cleanupAfterGame()
            }
        }
    }

    Timer
    {
        id: reloadBarTimer
        interval: 40
        running: false
        repeat: true

        property int reloadProgress: parent.finalReloadProgress

        onTriggered:
        {
            if(reloadProgress == parent.finalReloadProgress - 1)
            {
                running = false
            }
            reloadProgress = reloadProgress + 1
        }
    }

    function reload()
    {
        reloadBarTimer.running = true
        reloadBarTimer.reloadProgress = 0
    }
}