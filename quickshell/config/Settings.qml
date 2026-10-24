pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias appearance: adapter.appearance
    property alias wallpaper: adapter.wallpaper
    property alias island: adapter.island

    FileView {
        id: file
        path: Quickshell.env("HOME") + "/.config/quickshell/settings.json"

        blockLoading: true
        watchChanges: true

        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound)
                writeAdapter();
        }

        adapter: JsonAdapter {
            id: adapter

            property JsonObject appearance: JsonObject {
                property string accent: "#f74c00"
                property string text: "#ffffff"
                property string background: "#000000"
                property string placeholder: "gray"
            }

            property JsonObject wallpaper: JsonObject {
                property string path: ""
                property real margin: 0
                property real radius: 0
            }

            property JsonObject island: JsonObject {
                property real height: 35
                property real contentBottomLeftRadius: 20
                property real contentBottomRightRadius: 20
            }
        }
    }
}
