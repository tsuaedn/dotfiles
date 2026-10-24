pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

QtObject {
    id: root

    property var history: []

    property Process listProcess: Process {
        command: ["cliphist", "list"]

        stdout: StdioCollector {
            onStreamFinished: {
                const entries = [];

                for (const line of this.text.split("\n")) {
                    if (line.trim().length === 0)
                        continue;
                    const separator = line.indexOf("\t");

                    if (separator === -1)
                        continue;
                    entries.push({
                        id: line.substring(0, separator),
                        text: line.substring(separator + 1),
                        raw: line
                    });
                }

                root.history = entries;
            }
        }

        onStarted: {
            root.history = [];
        }
    }

    property Process deleteProcess: Process {
        command: ["cliphist", "delete"]

        stdinEnabled: true

        onExited: {
            root.refresh();
        }
    }

    property Process wipeProcess: Process {
        command: ["cliphist", "wipe"]

        onExited: {
            root.history = [];
        }
    }

    function refresh() {
        if (listProcess.running)
            return;
        listProcess.running = true;
    }

    function copy(item) {
        if (!item)
            return;
        Quickshell.execDetached(["sh", "-c", "printf '%s\\n' \"$1\" | cliphist decode | wl-copy", "--", item.raw]);
    }

    function deleteItem(item) {
        if (!item)
            return;
        if (deleteProcess.running)
            return;
        deleteProcess.start();

        deleteProcess.write(item.raw + "\n");
        deleteProcess.closeWrite();
    }

    function clearAll() {
        if (wipeProcess.running)
            return;
        wipeProcess.start();
    }

    Component.onCompleted: {
        refresh();
    }
}
