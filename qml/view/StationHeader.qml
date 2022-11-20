/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import "../service"

RowLayout {
    property var station

    id: header

    Layout.fillWidth: true
    Layout.preferredHeight: 200
    Layout.maximumHeight: 200
    Layout.minimumHeight: 200

    spacing: Theme.paddingLarge

    CoverView {
        id: stationCover

        Layout.fillHeight: true
        Layout.maximumWidth: parent.height
        Layout.preferredWidth: parent.height

        cover: header.station.cover
    }

    ColumnLayout {
        Layout.fillHeight: true
        Layout.fillWidth: true
        // only avaible starting with QtQuick.Layouts 1.3
        // Layout.margins: Theme.paddingLarge
        // Layout.topMargin: Theme.paddingMedium
        // Layout.bottomMargin: Theme.paddingMedium

        spacing: Theme.paddingMedium

        /* for spacing */
        Item { Layout.fillWidth: true; Layout.preferredHeight: 0 }

        Label {
            Layout.fillWidth: true
            Layout.fillHeight: true

            text: station.title

            verticalAlignment: Text.AlignVCenter
            font.pixelSize: Theme.fontSizeMedium
            color: Theme.primaryColor

            wrapMode: Text.WordWrap
            truncationMode: TruncationMode.Elide
        }

        Button {
            /**
             * using preudocode: `isSubscribed(station) implies _flag`.
             */
            property bool _flag: true

            text: qsTr("Subscribe")
            enabled: _flag || (station.status === Component.Ready)

            function _update() {
                Dao.isSubscribed(station.feed_url.toString(), function (flag) {
                    _updateText(flag);
                });
            }

            function _updateText(flag) {
                _flag = flag;
                text = _flag
                        ? qsTr("Unsubscribe")
                        : qsTr("Subscribe");
            }

            Component.onCompleted: {
                Dao.subscription.connect(function(url, flag) {
                    if (url === station.feed_url.toString()) {
                        _updateText(flag);
                    }
                });
                header.stationChanged.connect(function() {
                    _update();
                });
                _update();
            }

            onClicked: {
                var url = station.feed_url.toString();
                if (_flag) {
                    Dao.unsubscribe(url);
                } else {
                    Dao.subscribe(url);
                }
            }
        }

        /* for spacing */
        Item { Layout.fillWidth: true; Layout.preferredHeight: 0 }
    }
}
