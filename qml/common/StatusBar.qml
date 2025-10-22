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

    ColumnLayout
    {
        width: 200
        height: parent.height
        spacing: 0

        anchors
        {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }

        Text
        {
            id: reloadText
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 20
            text: "Reload"
        }

        Rectangle
        {
            id: reloadRect
            Layout.alignment: Qt.AlignHCenter
            color: "red"
            width: parent.width
            height: 20

            Rectangle
            {
                id: reloadProgressRect
                anchors.left: parent.left
                width: parent.width
                height: parent.height
                color: "green"
            }
        }
    }
}