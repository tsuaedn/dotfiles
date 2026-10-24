import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

import qs.ui.island.widgets
import qs.services
import qs.config
import qs.state

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: root

        required property var modelData
        screen: modelData

        anchors.top: true
        anchors.left: true
        anchors.right: true

        exclusiveZone: Settings.appearance.islandHeight
        implicitHeight: modelData.height

        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: (root.mode !== "clock") ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

        property string mode: Hyprland.focusedMonitor?.name === modelData.name ? GlobalState.islandMode : "clock"
        color: root.mode === "clock" ? "transparent" : Qt.rgba(0, 0, 0, 0.5)

        mask: Region {
            item: mask
        }

        MouseArea {
            z: 0
            anchors.fill: parent
            enabled: root.mode !== "clock"
            onClicked: {
                GlobalState.islandMode = "clock";
            }
        }

        // Content
        Rectangle {
            id: content
            z: 1

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: Fullscreen.active && root.mode === "clock" ? -content.implicitHeight : 0

            implicitHeight: widgets.implicitHeight
            implicitWidth: widgets.implicitWidth

            color: Settings.appearance.background

            bottomLeftRadius: Settings.appearance.islandContentBottomLeftRadius
            bottomRightRadius: Settings.appearance.islandContentBottomRightRadius

            clip: true
            antialiasing: true
            layer.enabled: true
            layer.smooth: true
            layer.effect: MultiEffect {
                maskEnabled: true
                maskSource: mask
            }

            // Animations

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 320
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 320
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on radius {
                NumberAnimation {
                    duration: 30
                }
            }
            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }

            // Widgets
            ColumnLayout {
                id: widgets
                anchors.centerIn: parent

                Clock {
                    visible: root.mode === "clock"
                }

                ActionBar {
                    visible: root.mode === "actionbar"
                }
            }
        }
        // -- Content End

        // Mask
        Rectangle {
            id: mask

            anchors.fill: content
            radius: content.radius
            bottomLeftRadius: content.bottomLeftRadius
            bottomRightRadius: content.bottomRightRadius

            visible: false
            layer.enabled: true
        }

        IpcHandler {
            target: "shell"

            function toggleLauncher(): void {
                if (root.mode !== "actionbar") {
                    GlobalState.islandMode = "actionbar";
                } else {
                    GlobalState.islandMode = "clock";
                }
            }
        }
    }
}
