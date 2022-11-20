/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "../view"

CoverBackground {

    ColumnLayout {
        id: layout
        anchors.fill: parent
        spacing: Theme.paddingMedium

        CoverView {
            Layout.fillWidth: true
            Layout.preferredHeight: layout.width

            cover: nowPlaying ? nowPlaying.cover : Qt.resolvedUrl()
        }

        Item {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            Label {
                anchors.fill: parent
                anchors.leftMargin: Theme.paddingSmall
                anchors.rightMargin: Theme.paddingSmall
                verticalAlignment: Text.AlignTop

                text: nowPlaying ? qsTr("%1 — %2", "station and title").arg(nowPlaying.title).arg(nowPlaying.station.title) : ""
                font.pixelSize: Theme.fontSizeSmall
                elide: Text.ElideMiddle
                maximumLineCount: 1
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: !(player.playbackState === MediaPlayer.PlayingState) ? "image://theme/icon-cover-play" : "image://theme/icon-cover-pause"
            onTriggered: !(player.playbackState === MediaPlayer.PlayingState) ? player.play() : player.pause()
        }
    }
}
