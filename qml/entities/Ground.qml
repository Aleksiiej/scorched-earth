import Felgo 4.0
import QtQuick 2.0
import QtQuick.Shapes 1.10


EntityBase
{
    id: groundBase
    entityType: "ground"

    anchors.fill: parent

    property var groundPoints: [
        Qt.point(0, 500),
        Qt.point(1000, 500),
        Qt.point(1000, 600),
        Qt.point(1500, 600),
        Qt.point(1500, 700),
        Qt.point(0, 700),
        Qt.point(0, 500)
    ]
    
    Shape
    {
        id: groundShape

        ShapePath
        {
            fillColor: "green"
            strokeColor: "red"

            startX: groundPoints[0].x
            startY: groundPoints[0].y

            PathLine {x: groundPoints[1].x; y: groundPoints[1].y}
            PathLine {x: groundPoints[2].x; y: groundPoints[2].y}
            PathLine {x: groundPoints[3].x; y: groundPoints[3].y}
            PathLine {x: groundPoints[4].x; y: groundPoints[4].y}
            PathLine {x: groundPoints[5].x; y: groundPoints[5].y}
            PathLine {x: groundPoints[6].x; y: groundPoints[6].y}
        }
    }

    PolygonCollider
    {
        id: groundCollider
        bodyType: Body.Static
        vertices: groundPoints
    }
}