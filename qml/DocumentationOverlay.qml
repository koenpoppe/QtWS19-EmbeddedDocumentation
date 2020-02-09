import QtQuick 2.0
import QtQuick.Controls 2.1

Item {
    id: overlay

    property color backgroundColor: "#039"
    property color foregroundColor: "#fff"

    property var documentationController: null
    property var currentIndicatorRectangle: null
    property var currentDocumentation: {
        if (documentationController === null) return null
        if (currentIndicatorRectangle === null) return null
        return documentationController.documentationFor(currentIndicatorRectangle.documentationItem)
    }

    visible: false

    Item {
        id: colorOverlay
        anchors.fill: parent

        Rectangle {
            width: overlay.currentIndicatorRectangle !== null ? currentIndicatorRectangle.x + currentIndicatorRectangle.width : parent.width/2
            height: overlay.currentIndicatorRectangle !== null ? currentIndicatorRectangle.y : parent.height/2
            anchors.right: overlay.currentIndicatorRectangle !== null ? currentIndicatorRectangle.right : parent.horizontalCenter
            anchors.bottom: overlay.currentIndicatorRectangle !== null ? currentIndicatorRectangle.top : parent.verticalCenter
            color: overlay.backgroundColor
            opacity: overlay.visible ? 0.5 : 0.0
            Behavior on opacity { PropertyAnimation {}}
        }
        Rectangle {
            anchors.left: overlay.currentIndicatorRectangle !== null ? currentIndicatorRectangle.right : parent.horizontalCenter
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: overlay.currentIndicatorRectangle !== null ? currentIndicatorRectangle.bottom : parent.verticalCenter
            color: overlay.backgroundColor
            opacity: overlay.visible ? 0.5 : 0.0
            Behavior on opacity { PropertyAnimation {}}
        }
        Rectangle {
            anchors.left: overlay.currentIndicatorRectangle !== null ? currentIndicatorRectangle.left : parent.horizontalCenter
            anchors.top: overlay.currentIndicatorRectangle !== null ? currentIndicatorRectangle.bottom : parent.verticalCenter
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: overlay.backgroundColor
            opacity: overlay.visible ? 0.5 : 0.0
            Behavior on opacity { PropertyAnimation {}}
        }
        Rectangle {
            anchors.left: parent.left
            anchors.top: overlay.currentIndicatorRectangle !== null ? currentIndicatorRectangle.top : parent.verticalCenter
            anchors.right: overlay.currentIndicatorRectangle !== null ? currentIndicatorRectangle.left : parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: overlay.backgroundColor
            opacity: overlay.visible ? 0.5 : 0.0
            Behavior on opacity { PropertyAnimation {}}
        }

        // Click outside indicator rectangle hides the overlay
        MouseArea {
            anchors.fill: parent
            onClicked: overlay.visible = false
        }

        Repeater {
            model: overlay.visible ? documentationController.documentationItems : null // update when overlay becomes visible
            Rectangle {
                id: indicatorRectangle
                readonly property var documentationItem: modelData
                readonly property rect mappedRect: colorOverlay.mapFromItem(documentationItem, 0, 0, documentationItem.width, documentationItem.height)

                x: mappedRect.x - border.width
                y: mappedRect.y - border.width
                width: mappedRect.width + 2*border.width
                height: mappedRect.height + 2*border.width
                border.color: overlay.backgroundColor
                border.width: 3
                color: "transparent"

                MouseArea{
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: overlay.currentIndicatorRectangle = (overlay.currentIndicatorRectangle !== indicatorRectangle) ? indicatorRectangle : null
                }
            }
        }
    }

    PopOver {
        id: popOver
        visible: overlay.currentIndicatorRectangle !== null
        over: overlay.currentIndicatorRectangle
        color: overlay.backgroundColor
        Text {
            color: overlay.foregroundColor
            width: Math.min(200, implicitWidth)
            wrapMode: Text.WordWrap
            text: currentDocumentation ? currentDocumentation.brief : ""
        }
    }
}
