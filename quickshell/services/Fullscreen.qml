pragma Singleton
import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    readonly property bool active: (Hyprland.activeToplevel?.lastIpcObject?.fullscreen ?? 0) === 2

    function activeOn(screen): bool {
        const mon = Hyprland.monitorFor(screen);
        const wsId = mon?.activeWorkspace?.id;
        if (wsId === undefined)
            return false;

        return Hyprland.toplevels.values.some(t => t.workspace?.id === wsId && (t.lastIpcObject?.fullscreen ?? 0) === 2);
    }

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            switch (event.name) {
            case "fullscreen":
            case "activewindowv2":
            case "workspacev2":
            case "focusedmonv2":
            case "closewindow":
            case "movewindowv2":
                Hyprland.refreshToplevels();
                break;
            }
        }
    }
}
