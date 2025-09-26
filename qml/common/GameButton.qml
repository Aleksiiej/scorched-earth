import QtQuick 2.0

Rectangle
{
    id: gameButton

    width: buttonText.width + paddingHorizontal * 2
    height: buttonText.height + paddingVertical * 2

    color: "#e9e9e9"
    radius: 10

    property int paddingHorizontal: 10
    property int paddingVertical: 5

    property alias text: buttonText.text

    signal clicked

    Text
    {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: 18
        color: "black"
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: gameButton.clicked()
        onPressed: gameButton.opacity = 0.5
        onReleased: gameButton.opacity = 1
    }
}