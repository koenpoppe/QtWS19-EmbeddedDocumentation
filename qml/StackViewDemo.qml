import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import EmbeddedDocumentation 1.0

Page {
    header: RowLayout {
        Label {
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 10
            text: "StackView (depth: " + stackView.depth + ")"
        }
    }
    StackView {
        id: stackView
        anchors.fill: parent
        objectName: "stackView"
        initialItem: carnivora

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 300
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 300
            }
        }
        popEnter: pushEnter
        popExit: pushExit
    }

    QtObject {
        id: colors
        readonly property color level1: "#ece6d6"
        readonly property color level2: Qt.darker(level1, 1.2)
        readonly property color level3: Qt.darker(level2, 1.2)
    }

    Loader {
        id: carnivora
        StackViewDemoPage {
            anchors.fill: parent
            color: colors.level1
            title: "Carnivora"
            Button {
                text: "Canidae"
                onClicked: stackView.push(canidae)
            }
            Button {
                text: "Felidae"
                onClicked: stackView.push(felidae)
            }
            Button {
                text: "..."
            }
        }
    }

    Loader {
        id: canidae
        visible: false
        StackViewDemoPage {
            color: colors.level2
            title: "Canidae"
            icon: "🐶"
            description: "A lineage of carnivorans that includes domestic dogs, wolves, coyotes, foxes, jackals, dingoes, and many other extant and extinct dog-like mammals"
            Button {
                text: "↖️"
                onClicked: stackView.pop()
            }
            Button {
                text: "..."
            }
        }
    }

    Loader {
        id: felidae
        visible: false
        StackViewDemoPage {
            color: colors.level2
            title:"Felidae"
            icon: "🦁"
            description: "A family of mammals in the order Carnivora, colloquially referred to as cats, and constitutes a clade."
            Button {
                text: "↖"
                onClicked: stackView.pop()
            }
            Button {
                text: "Felinae"
                onClicked: stackView.push(felinae)
            }
            Button {
                text: "Pantherinae"
                onClicked: stackView.push(pantherinae)
            }
            Button {
                text: "..."
            }
        }
    }
    Loader {
        id: felinae
        visible: false
        StackViewDemoPage {
            color: colors.level3
            title: "Felinae"
            icon: "🐱"
            description: "This subfamily comprises the small cats having a bony hyoid, because of which they are able to purr but not roar."
            Button {
                text: "↖️"
                onClicked: stackView.pop()
            }
            Button {
                text: "..."
            }
        }
    }
    Loader {
        id: pantherinae
        visible: false
        StackViewDemoPage {
            color:colors.level3
            title: "Pantherinae"
            icon: "🐯"
            description: "Pantherinae is a subfamily within the family Felidae, which was named and first described by Reginald Innes Pocock in 1917."
            Button {
                text: "↖️"
                onClicked: stackView.pop()
            }
            Button {
                text: "..."
            }
        }
    }
}
