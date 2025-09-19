import QtQuick 2.0

Rectangle
{
    anchors.centerIn: parent
    color: "lightgrey"
    Column
    {
        spacing: 10
        anchors.centerIn: parent
        Rectangle
        {
            width: 100
            height: 50
            color: "lightblue"
            Text
            {
                text: "New Game"
                color: "Black"
                anchors.centerIn: parent
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked: 
                {
                    console.debug("New Game clicked")
                }
            }
        }
        Rectangle
        {
            width: 100
            height: 50
            color: "lightblue"
            Text
            {
                text: "Exit Game"
                color: "Black"
                anchors.centerIn: parent
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked: 
                {
                    Qt.quit()
                }
            }
        }
    }
}
