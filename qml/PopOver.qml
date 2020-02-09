import QtQuick 2.0

Item {
    id: popOver

    // What item is this popping over
    property var over: null
    readonly property rect overRect: over === null ? Qt.rect(0,0,0,0) : parent.mapFromItem(over, 0*over.x, 0*over.y, over.width, over.height)

    // Size of the triangle pointing to the over item
    property int anchorSize: 10
    readonly property int radius: anchorSize

    // Background color
    property color color: "#CCCCCC"

    // Forward content
    default property alias contentItem: contentItem.data

    // Simple layout: choose side with most space
    QtObject {
        id: layout
        function orientedFreeSpace(leading, size, total, allowIndeterminate) {
            var trailing = total - (leading + size)
            if (leading > trailing) {
                return -leading
            }
            else if (leading < trailing) {
                return trailing
            }
            else if (allowIndeterminate){
                return 0
            }
            else {
                return -leading
            }
        }
        function popOverLeading(leading, size, popSize, popMult) {
            return leading + size*(1+popMult)/2 - popSize*(1-popMult)/2
        }
        function anchorLeading(size, popSize, popMult) {
            return popSize*(1-popMult)/2 - size*(1-popMult)/2
        }
        function contentLeading(size, popMult) {
            if (popMult === 0) {
                return 0
            }
            return size*(1+popMult)/4
        }
    }
    readonly property int horizontalPopDirection: layout.orientedFreeSpace(overRect.x, overRect.width, parent.width, true)
    readonly property int verticalPopDirection: layout.orientedFreeSpace(overRect.y, overRect.height, parent.height, false)
    readonly property bool popHorizontal: Math.abs(horizontalPopDirection) > Math.abs(verticalPopDirection)
    readonly property int horizontalPopMult: popHorizontal ? Math.sign(horizontalPopDirection) : 0
    readonly property int verticalPopMult: popHorizontal ? 0 : Math.sign(verticalPopDirection)
    x: layout.popOverLeading(overRect.x, overRect.width, width, horizontalPopMult)
    y: layout.popOverLeading(overRect.y, overRect.height, height, verticalPopMult)
    width: contentContainer.width + (popHorizontal ? anchor.width/2 : 0)
    height: contentContainer.height + (popHorizontal ? 0 : anchor.height/2)

    // Anchor
    Item {
        id: anchor
        x: layout.anchorLeading(anchor.width, popOver.width, popOver.horizontalPopMult)
        y: layout.anchorLeading(anchor.height, popOver.height, popOver.verticalPopMult)
        width: 2*popOver.anchorSize
        height: width
        Rectangle {
            anchors.centerIn: parent
            rotation: 45
            width: parent.width * Math.SQRT1_2
            height: width
            color: popOver.color
        }
    }

    // Content
    Rectangle {
        id: contentContainer
        color: popOver.color
        x: layout.contentLeading(anchor.width, popOver.horizontalPopMult)
        y: layout.contentLeading(anchor.height, popOver.verticalPopMult)
        width: contentItem.childrenRect.width + 2*content.anchors.margins
        height: contentItem.childrenRect.height + 2*content.anchors.margins
        radius: popOver.radius

        Item {
            id: content
            anchors.fill: parent
            anchors.margins: contentContainer.radius
            Item {
                id: contentItem
                anchors.fill: parent
            }
        }
    }
}
