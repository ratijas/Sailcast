/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtMultimedia 5.0
import Sailfish.Silica 1.0

BackgroundItem {
    id: element

    property bool isCurrent: Qt.resolvedUrl(model.enclosure).toString() === player.source.toString()

    width: parent ? parent.width : undefined
    height: Theme.iconSizeLarge

    RowLayout {
        anchors.fill: parent
        spacing: Theme.paddingMedium

        CoverView {
            Layout.minimumWidth: parent.height
            Layout.preferredWidth: parent.height
            Layout.maximumWidth: parent.height
            Layout.minimumHeight: parent.height

            cover: model.cover
            highlighted: element.highlighted
        }

        Label {
            id: title

            Layout.fillWidth: true
            Layout.fillHeight: true

            text: model.title

            color: isCurrent ? Theme.highlightColor : Theme.primaryColor
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: Theme.fontSizeMedium
            truncationMode: TruncationMode.Elide
        }
        Image {
            Layout.minimumWidth: Theme.iconSizeMedium
            Layout.preferredWidth: Theme.iconSizeMedium
            Layout.maximumWidth: Theme.iconSizeMedium
            Layout.minimumHeight: Theme.iconSizeMedium
            Layout.preferredHeight: Theme.iconSizeMedium
            Layout.maximumHeight: Theme.iconSizeMedium
            source: ("image://theme/icon-l-" +
                     (isCurrent && player.playbackState === MediaPlayer.PlayingState ? "pause" : "play"))
        }
    }
}
