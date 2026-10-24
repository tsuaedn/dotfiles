import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets

import QtQuick
import QtMultimedia

import qs.config

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: wallpaper

        required property var modelData
        screen: modelData

        readonly property string path: Settings.wallpaper.path
        readonly property string url: path !== "" ? "file://" + path : ""
        readonly property bool isVideo: /\.(mp4|webm|mkv|mov)$/i.test(path)

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Background
        WlrLayershell.namespace: "wallpaper"
        color: Settings.appearance.background

        ClippingRectangle {
            id: frame
            anchors.fill: parent
            anchors.margins: Settings.wallpaper.margin
            radius: Settings.wallpaper.radius
            color: Settings.appearance.background

            Loader {
                anchors.fill: parent
                active: wallpaper.url !== ""
                sourceComponent: wallpaper.isVideo ? videoWallpaper : imageWallpaper
            }
        }

        Component {
            id: imageWallpaper

            Image {
                source: wallpaper.url
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                cache: false
                smooth: true

                opacity: status === Image.Ready ? 1 : 0
                Behavior on opacity {
                    NumberAnimation {
                        duration: 400
                    }
                }
            }
        }

        Component {
            id: videoWallpaper

            Item {
                MediaPlayer {
                    source: wallpaper.url
                    autoPlay: true
                    loops: MediaPlayer.Infinite
                    audioOutput: AudioOutput {
                        muted: true
                    }
                    videoOutput: output
                }

                VideoOutput {
                    id: output
                    anchors.fill: parent
                    fillMode: VideoOutput.PreserveAspectCrop
                }
            }
        }
    }
}
