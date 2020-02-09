import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import EmbeddedDocumentation 1.0

Rectangle {
    id: page
    anchors.fill: parent

    property string title: "title"
    property string icon: ""
    property string description: ""
    default property alias contents: rowLayout.children

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 8
        Text {
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 40
            font.underline: true
            text: page.title

            Documentation.brief: "Name of the species"
        }
        Text {
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 120
            text: page.icon
            visible: page.icon !== ""
            Documentation.brief: "Totally representative example of the species"
        }
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: 200
            text: page.description
            visible: page.description !== ""
            Documentation.brief: "Description from wikipedia"
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignJustify
        }
        RowLayout {
            id: rowLayout
            Layout.alignment: Qt.AlignHCenter
            Documentation.brief: "Navigation"
        }
    }
}
