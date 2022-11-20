/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import "../service"

RowLayout {
    id: header

    property var station
    property bool subscribed

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

            text: header.station.title

            verticalAlignment: Text.AlignVCenter
            font.pixelSize: Theme.fontSizeMedium
            color: Theme.primaryColor

            wrapMode: Text.WordWrap
            truncationMode: TruncationMode.Elide
        }

        Button {
            text: header.subscribed
                ? qsTr("Unsubscribe")
                : qsTr("Subscribe")
            enabled: header.subscribed || (header.station.status === Component.Ready)

            onClicked: {
                var url = header.station.feed_url.toString();
                if (header.subscribed) {
                    Dao.unsubscribe(url);
                } else {
                    Dao.subscribe(url);
                }
            }
        }

        /* for spacing */
        Item { Layout.fillWidth: true; Layout.preferredHeight: 0 }
    }

    function _update() {
        Dao.isSubscribed(station.feed_url.toString(), function (flag) {
            header.subscribed = flag;
        });
    }

    onStationChanged: _update()
    Component.onCompleted: {
        _update();
        Dao.subscription.connect(function(url, flag) {
            if (url === station.feed_url.toString()) {
                header.subscribed = flag;
            }
        });
    }
}
