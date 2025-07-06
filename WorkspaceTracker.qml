import Quickshell.Hyprland
import QtQuick

Row {
    id: workspaceRow
    ListModel {
        id: textModel
    }

    spacing: 20

    Repeater {
        model: textModel
        delegate: Text {
            text: model.text
            font.family: "JetBrains Mono NF"
            font.bold: true
            font.pointSize: 13
            color: Constants.textColor
        }
    }

    property var focusedWorkspace: Hyprland.focusedWorkspace
    property int numWorkspaces: -1
    property list<int> validWorkspaces: [-1]

    // Update repeater on workspace changes
    onFocusedWorkspaceChanged: {
        textModel.clear();
        validWorkspaces = [];

        // Store the id's of all active workspaces
        for (var i = 0; i < Hyprland.workspaces.values.length; i++) {
            validWorkspaces.push(Hyprland.workspaces.values[i].id);
        }

        numWorkspaces = validWorkspaces[Hyprland.workspaces.values.length - 1];

        for (var i = 1; i < numWorkspaces + 1; i++) {
            // Append an indicator every few icons for readability
            if ((i - 1) % 3 == 0 && i - 1 > 0) {
                textModel.append({
                    text: "|"
                });
            }
            // Logic to handle if a workspace is focused or valid
            if (i == focusedWorkspace.id) {
                textModel.append({
                    text: "󰧲"
                });
            } else if (validWorkspaces.indexOf(i) != -1) {
                textModel.append({
                    text: ""
                });
            } else {
                textModel.append({
                    text: "󱏺"
                });
            }
        }
    }
}
