import Felgo 4.0
import QtQuick 2.0
import QtQuick.Layouts

RowLayout
{
    id: playerStatusBar
    spacing: 20

    property var title: ""
    property var playerNumber: 0
    property var playerRef: null

    Text
    {
        text: parent.title
        Layout.leftMargin: 25
        font.pixelSize: 25
    }

    ColumnLayout
    {
        width: 200
        Layout.leftMargin: 20

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
                width: playerRef ? playerRef.hpAmount * (parent.width / 100) : 0
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
            text: "Score"
        }

        Text
        {
            id: scoreText
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 20
            text: playerNumber == 1 ? gameScene.player1Score : gameScene.player2Score
        }
    }

    Timer
    {
        id: reloadBarTimer
        interval: 40
        running: false
        repeat: true

        property int reloadProgress: statusBar.finalReloadProgress

        onTriggered:
        {
            if(reloadProgress == statusBar.finalReloadProgress - 1)
            {
                running = false
            }
            reloadProgress = reloadProgress + 1
        }
    }

    function reloadPlayer()
    {
        reloadBarTimer.running = true
        reloadBarTimer.reloadProgress = 0
    }
}