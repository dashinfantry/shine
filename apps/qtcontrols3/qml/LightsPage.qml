/*
 * Copyright 2013 Michael Zanetti
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 2.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authors:
 *      Michael Zanetti <michael_zanetti@gmx.net>
 */

import QtQuick 2.5
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import Hue 0.1
import "PopupUtils.js" as PopupUtils

ShinePage {
    id: root
    title: "Lights"
    busy: lights && lights.count === 0 && lights.busy

    property alias lights: lightsFilterModel.lights
    property var groups: null
    property var schedules: null

    toolButtons: ListModel {
        ListElement { text: "add"; image: "add" }
    }
    onToolButtonClicked: {
        var popup = PopupUtils.open(Qt.resolvedUrl("CreateDialog.qml"), root, {mode: "group", lights: root.lights})
        popup.accepted.connect(function(name, lightsList) {
            groups.createGroup(name, lightsList);
        })
    }

    Item { // wrap flickable to disable header fancyness
        anchors.fill: parent
        clip: true

        Flickable {
            id: mainFlickable
            anchors.fill: parent
            contentHeight: mainColumn.height
            interactive: contentHeight > height

            Column {
                id: mainColumn
                anchors { left: parent.left; right: parent.right }

                Label {
                    text: "Groups"
                    anchors {left: parent.left; right: parent.right; margins: 8 * (2) }
                    height: 8 * (3)
                    verticalAlignment: Text.AlignVCenter
                }

                ThinDivider {}

                Repeater {
                    model: groups

                    delegate: LightDelegate {
                        light: groups.get(index)
                        height: 60
                        width: parent.width
                        schedules: root.schedules
                        Connections {
                            target: groups.get(index)
                            onWriteOperationFinished: {
                                root.lights.refresh()
                            }
                        }
                    }
                }

                Label {
                    anchors {left: parent.left; right: parent.right; margins: 8 * (2) }
                    text: "Lights"
                    height: 8 * (3)
                    verticalAlignment: Text.AlignVCenter
                }

                ThinDivider {}

                Repeater {
                    model: LightsFilterModel {
                        id: lightsFilterModel
                    }
                    delegate: LightDelegate {
                        light: lightsFilterModel.get(index)
                        schedules: root.schedules
                        height: 60
                        width: parent.width
                        Connections {
                            target: lightsFilterModel.get(index)
                            onWriteOperationFinished: {
                                root.groups.refresh()
                            }
                        }
                    }
                }
            }
        }
    }
}

