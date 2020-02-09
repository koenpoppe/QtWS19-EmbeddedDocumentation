import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import EmbeddedDocumentation 1.0

Page {
    header: RowLayout {
        Label {
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 10
            text: "Basic controls"
        }
    }

    ColumnLayout {
        spacing: 40
        anchors.centerIn: parent

        RowLayout {
            id: mediaControl
            Layout.alignment: Qt.AlignHCenter

            property bool playing: false
            Button {
                id: playPauseButton
                text: mediaControl.playing ? "⏸️" : "⏯️"
                onClicked: mediaControl.playing = !mediaControl.playing
            }
            BusyIndicator {
                visible: mediaControl.playing
                Layout.preferredHeight: playPauseButton.height
            }

            Documentation.brief: "Media controls"
        }

        SpinBox {
            id: documentationTeamMembers
            Layout.alignment: Qt.AlignHCenter

            from: 0
            value: 1

            Documentation.brief: "#members in documentation team"
        }
    }
}
