/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "pages"
import "model"
import "service"

ApplicationWindow {
    /**
     * Currently playing `Episode` instance.
     */
    property var nowPlaying

    initialPage: Component { SubscriptionsPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

    MediaPlayer {
        id: player
    }
}
