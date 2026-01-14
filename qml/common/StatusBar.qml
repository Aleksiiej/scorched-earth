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
        id: player1StatusLayout
        spacing: 20

        Text
        {
            text: "Player1"
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
                    width: player1ReloadBarTimer.player1ReloadProgress * (parent.width / statusBar.finalReloadProgress)
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
                    width: gameScene.player1 ? gameScene.player1.hpAmount * (parent.width / 100) : 0
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
                id: scoreTextPlayer1
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 20
                text: gameScene.player1Score
            }
        }
    }

    RowLayout
    {
        id: player2StatusLayout
        spacing: 20
        opacity: gameScene.isMultiplayer ? 1 : 0

        anchors.left: player1StatusLayout.right

        Text
        {
            text: "Player2"
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
                    width: player2ReloadBarTimer.player2ReloadProgress * (parent.width / statusBar.finalReloadProgress)
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
                    width: gameScene.player2 ? gameScene.player2.hpAmount * (parent.width / 100) : 0
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
                id: scoreTextPlayer2
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 20
                text: gameScene.player2Score
            }
        }
    }

    CommonButton
    {
        text: "Back to menu"
        anchors
        {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 20
        }

        onClicked:
        {
            backToMenuPressed()
            cleanupAfterGame()
        }
    }

    Timer
    {
        id: player1ReloadBarTimer
        interval: 40
        running: false
        repeat: true

        property int player1ReloadProgress: parent.finalReloadProgress

        onTriggered:
        {
            if(player1ReloadProgress == parent.finalReloadProgress - 1)
            {
                running = false
            }
            player1ReloadProgress = player1ReloadProgress + 1
        }
    }

    Timer
    {
        id: player2ReloadBarTimer
        interval: 40
        running: false
        repeat: true

        property int player2ReloadProgress: parent.finalReloadProgress

        onTriggered:
        {
            if(player2ReloadProgress == parent.finalReloadProgress - 1)
            {
                running = false
            }
            player2ReloadProgress = player2ReloadProgress + 1
        }
    }

    function reloadPlayer1()
    {
        player1ReloadBarTimer.running = true
        player1ReloadBarTimer.player1ReloadProgress = 0
    }

    function reloadPlayer2()
    {
        player2ReloadBarTimer.running = true
        player2ReloadBarTimer.player2ReloadProgress = 0
    }
}