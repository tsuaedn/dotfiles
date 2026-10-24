pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias appearance: adapter.appearance

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

                property string wallpaper: ""
                property int wallpaperMargin: 0
                property real wallpaperRadius: 0

                property real islandHeight: 35
                property real islandContentBottomLeftRadius: 20
                property real islandContentBottomRightRadius: 20
            }
        }
    }
}
