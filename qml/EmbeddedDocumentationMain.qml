import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12

import EmbeddedDocumentation 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("EmbeddedDocumentation")

    Page {
        id: mainPage
        anchors.fill: parent

        SwipeView {
            id: swipeView
            anchors.fill: parent

            ControlsDemo {
            }

            StackViewDemo {
            }
        }
        footer: Item {
            height: documentationToggle.height
            PageIndicator {
                anchors.centerIn: parent
                count: swipeView.count
                currentIndex: swipeView.currentIndex
            }
            Button {
                id: documentationToggle
                anchors.right: parent.right
                anchors.rightMargin: 5
                text: "?"
                onClicked: documentationOverlay.visible = true
            }
        }
    }

    DocumentationOverlay {
        id: documentationOverlay
        anchors.fill: parent
        documentationController: documentationController
    }
    DocumentationController {
        id: documentationController
        root: mainPage
    }
}
