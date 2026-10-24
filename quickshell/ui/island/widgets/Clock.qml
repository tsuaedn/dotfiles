import QtQuick
import QtQuick.Layouts

import Quickshell

import qs.config
import qs.services
import qs.ui.island.widgets

Rectangle {
    id: root

    implicitWidth: 350
    implicitHeight: Settings.appearance.islandHeight

    Layout.alignment: Qt.AlignCenter
    color: "transparent"

    Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "hh:mm")

        color: Fullscreen.active ? Settings.appearance.background : Settings.appearance.accent
        font.bold: true

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }
    }
}
