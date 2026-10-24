import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

import qs.services
import qs.config
import qs.state

FocusScope {
    id: root

    implicitWidth: 500
    implicitHeight: layout.implicitHeight

    property string mode: input.text.startsWith("=") ? "calc" : input.text.startsWith(":") ? "clipboard" : "launcher"

    property var allEntries: {
        var entries = [];
        if (root.mode === "launcher") {
            for (var i = 0; i < DesktopEntries.applications.values.length; i++) {
                var e = DesktopEntries.applications.values[i];
                entries.push({
                    name: e.name,
                    icon: e.icon,
                    comment: e.comment,
                    entry: e
                });
            }

            entries.sort((a, b) => a.name.localeCompare(b.name));
        }

        return entries;
    }

    property var filteredEntries: {
        resetToFirst.start();
        if (mode === "launcher") {
            const filtered = allEntries.filter(a => a.name.toLowerCase().includes(input.text.toLowerCase()));

            if (filtered.length === 0) {
                list.currentIndex = -1;

                return [
                    {
                        icon: "help-circle",
                        name: "No items",
                        comment: "",
                        entry: null
                    }
                ];
            }

            list.currentIndex = 0;
            return filtered;
        } else if (mode === "calc") {
            const expr = input.text.substring(1);

            if (expr.length === 0) {
                return [
                    {
                        icon: "=",
                        name: "Start calculating..."
                    }
                ];
            }

            try {
                const result = eval(expr);

                return [
                    {
                        icon: "󰇼",
                        name: result.toString(),
                        comment: expr,
                        entry: null
                    }
                ];
            } catch (e) {
                return [
                    {
                        icon: "",
                        name: "Invalid expression",
                        comment: e.toString(),
                        entry: null
                    }
                ];
            }
        } else if (mode === "clipboard") {
            const query = input.text.substring(1).trim().toLowerCase();

            const filtered = Clipboard.history.filter(item => item.text.toLowerCase().includes(query));

            if (filtered.length === 0) {
                list.currentIndex = -1;

                return [
                    {
                        type: "empty",
                        icon: "clipboard",
                        name: "No clipboard items",
                        comment: "",
                        entry: null
                    }
                ];
            }

            list.currentIndex = 0;

            return filtered.map(item => ({
                        type: "clipboard",
                        id: item.id,
                        text: item.text,
                        raw: item.raw,
                        icon: "clipboard",
                        name: item.text,
                        comment: ""
                    }));
        }

        return [];
    }

    ScriptModel {
        id: filteredModel
        values: root.filteredEntries
    }

    function launch(app) {
        app.entry.execute();
        root.close();

        Quickshell.execDetached(["hyprctl", "dispatch", "focuscurrentorlast"]);
    }

    function close() {
        list.positionViewAtIndex(list.currentIndex, ListView.Contain);
        list.currentIndex = 0;
        GlobalState.islandMode = "clock";
        input.text = "";
    }

    onVisibleChanged: {
        if (visible) {
            forceFocus.start();

            list.currentIndex = 0;
            input.text = "";

            Clipboard.refresh();
        }
    }

    Component.onCompleted: {
        if (visible)
            forceFocus.start();
    }

    Timer {
        id: forceFocus
        interval: 0
        onTriggered: input.forceActiveFocus()
    }

    Timer {
        id: resetToFirst
        interval: 100
        onTriggered: {
            list.currentIndex = 0;
        }
    }

    ColumnLayout {
        id: layout

        width: parent.width

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        spacing: 14

        // Action Bar
        Rectangle {
            id: actionBar

            Layout.fillWidth: true
            Layout.preferredHeight: 50

            radius: 14
            color: "transparent"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 14
                anchors.rightMargin: 14

                Text {
                    text: "󰍉"
                    color: Settings.appearance.accent

                    font.family: "JetBrainsMono Nerd Font Propo"
                    font.pixelSize: 18
                }

                TextField {
                    id: input

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    background: Item {}

                    color: Settings.appearance.text
                    placeholderText: "Search Apps or Enter a Command"
                    placeholderTextColor: Settings.appearance.placeholder

                    selectByMouse: true
                    font.pixelSize: 15

                    onTextChanged: {
                        list.currentIndex = 0;
                        list.positionViewAtIndex(0, ListView.Beginning);
                    }

                    Keys.onPressed: event => {
                        if (event.key === Qt.Key_Escape) {
                            input.text = "";
                            root.close();
                            event.accepted = true;
                        } else if (event.key === Qt.Key_Down) {
                            list.currentIndex = Math.min(list.currentIndex + 1, filteredEntries.length - 1);
                            event.accepted = true;
                        } else if (event.key === Qt.Key_Up) {
                            list.currentIndex = Math.max(list.currentIndex - 1, 0);
                            event.accepted = true;
                        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            if (root.mode === "launcher") {
                                root.launch(filteredEntries[list.currentIndex]);
                            } else if (root.mode === "clipboard") {
                                Clipboard.copy(filteredEntries[list.currentIndex]);
                                root.close();
                            }

                            event.accepted = true;
                        }
                    }
                }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                height: 1
                color: Settings.appearance.accent
            }
        }

        // Results
        Item {

            Layout.fillWidth: true

            Layout.preferredHeight: root.filteredEntries.length >= 6 ? (6 * 60) + (5 * 8) + 14 : (root.filteredEntries.length * 60) + ((root.filteredEntries.length - 1) * 8) + 14

            ListView {
                id: list

                anchors.fill: parent

                anchors.leftMargin: 14
                anchors.rightMargin: 14

                clip: true

                spacing: 8

                model: filteredModel

                currentIndex: 0

                interactive: false

                delegate: Rectangle {

                    required property var modelData
                    required property int index

                    width: list.width
                    height: 60

                    radius: 15

                    color: index === list.currentIndex ? Settings.appearance.accent : "transparent"

                    RowLayout {

                        anchors.fill: parent

                        anchors.leftMargin: 14
                        anchors.rightMargin: 14

                        spacing: 14

                        Rectangle {

                            width: 36
                            height: 36

                            color: "transparent"

                            Image {
                                anchors.centerIn: parent
                                visible: root.mode !== "calc"

                                width: 34
                                height: 34

                                source: Quickshell.iconPath(modelData.icon, false)
                                fillMode: Image.PreserveAspectFit
                            }

                            Text {
                                anchors.centerIn: parent
                                visible: root.mode === "calc"
                                text: "="

                                font.family: "JetBrainsMono Nerd Font Propo"

                                font.pixelSize: 28

                                color: Settings.appearance.background
                            }
                        }

                        ColumnLayout {

                            Layout.fillWidth: true

                            spacing: 2

                            Text {

                                Layout.fillWidth: true

                                text: modelData.name

                                font.pixelSize: 13

                                color: root.mode === "calc" ? Settings.appearance.background : Settings.appearance.text
                            }

                            Text {

                                Layout.fillWidth: true

                                visible: !!modelData.comment
                                text: modelData.comment
                                font.pixelSize: 10
                                color: root.mode === "calc" ? Settings.appearance.background : Settings.appearance.placeholder
                            }
                        }
                    }
                }
            }
        }
    }
}
