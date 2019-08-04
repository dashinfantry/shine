import QtQuick 2.5
import Sailfish.Silica 1.0
import Hue 0.1
import harbour.scintillon.settings 1.0

Item {
    id: hueDimmer
    property int buttonId: buttonNumber + "00" + buttonMode

    property int buttonNumber: 1
    property int buttonMode: pressCheckBox.checked ? 2 : 1
    property var rules
    property var sensor

    height: hueDimmerRow.height

    function createSensorConditions() {
        return rules.createHueDimmerConditions(sensor.id, hueDimmer.buttonId);
    }

    function createFilter() {
        var filter = new Object();
        filter["address"] = "/sensors/" + sensor.id + "/state/buttonevent"
        filter["operator"] = "eq"
        filter["value"] = hueDimmer.buttonId
        return filter
    }

    Row {
        id: hueDimmerRow
        width: parent.width
        spacing: Theme.paddingMedium

        Column {
            width: (parent.width) * 0.5
            spacing: Theme.paddingSmall

            TextSwitch {
                id: onButton
                width: parent.width
                text: "On"
                checked: hueDimmer.buttonNumber == 1
                automaticCheck: false
                onClicked: hueDimmer.buttonNumber = 1
            }

            TextSwitch {
                id: brighterButton
                width: parent.width
                text: "Brighter"
                checked: hueDimmer.buttonNumber == 2
                automaticCheck: false
                onClicked: hueDimmer.buttonNumber = 2
            }

            TextSwitch {
                id: dimmerButton
                width: parent.width
                text: "Dimmer"
                checked: hueDimmer.buttonNumber == 3
                automaticCheck: false
                onClicked: hueDimmer.buttonNumber = 3
            }

            TextSwitch {
                id: offButton
                width: parent.width
                text: "Off"
                checked: hueDimmer.buttonNumber == 4
                automaticCheck: false
                onClicked: hueDimmer.buttonNumber = 4
            }
        }

        Column {
            width: (parent.width) * 0.5
            spacing: Theme.paddingSmall

            IconButton {
                id: hueDimmerIcon
                width: Theme.iconSizeExtraLarge
                height: (Theme.itemSizeSmall * 2) + Theme.paddingSmall
                icon.source: {
                    switch (hueDimmer.buttonNumber) {
                    case 1:
                        return Qt.resolvedUrl("image://scintillon/sensors/dimmer-1")
                        break;
                    case 2:
                        return Qt.resolvedUrl("image://scintillon/sensors/dimmer-2")
                        break;
                    case 3:
                        return Qt.resolvedUrl("image://scintillon/sensors/dimmer-3")
                        break;
                    case 4:
                        return Qt.resolvedUrl("image://scintillon/sensors/dimmer-4")
                        break;
                    }
                    return Qt.resolvedUrl("image://scintillon/sensors/dimmer")
                }
                icon.color: "white"
            }

            TextSwitch {
                id: pressCheckBox
                checked: true
                automaticCheck: false
                onClicked: {
                    pressCheckBox.checked = true;
                    holdCheckBox.checked = false;
                }
                text: "Press"
            }

            TextSwitch {
                id: holdCheckBox
                automaticCheck: false
                onClicked: {
                    holdCheckBox.checked = true;
                    pressCheckBox.checked = false;
                }
                text: "Hold"
            }
        }
    }
}
