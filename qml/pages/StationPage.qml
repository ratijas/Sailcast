/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "../model"
import "../view"
import "../service"

Page {
    property var station


    id: page

    anchors.fill: parent

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // header
        RowLayout {
            property alias station: page.station

            id: header

            Layout.fillWidth: true
            Layout.preferredHeight: 200
            Layout.maximumHeight: 200
            Layout.minimumHeight: 200

            spacing: Theme.paddingLarge

            Image {
                id: stationCover

                Layout.fillHeight: true
                Layout.maximumWidth: parent.height
                Layout.preferredWidth: parent.height

                fillMode: Image.PreserveAspectFit

                source: header.station.cover
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Label {
                    Layout.fillWidth: true
                    text: station.title
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.primaryColor

                    wrapMode: Text.WordWrap
                }

                Button {
                    property bool _flag: true

                    text: qsTr("Subscribe")

                    function updateText(flag) {
                        _flag = flag;
                        text = _flag
                                ? qsTr("Unsubscribe")
                                : qsTr("Subscribe");
                    }

                    Component.onCompleted: {
                        Dao.subscription.connect(function(url, flag) {
                            if (url === station.feed_url.toString()) {
                                updateText(flag);
                            }
                        });
                        Dao.isSubscribed(station.feed_url.toString(), function (flag) {
                            updateText(flag);
                        });
                    }
                }
            }
        }

        SilicaListView {
            id: listView

            Layout.fillHeight: true
            Layout.fillWidth: true

            clip: true

            model: MyEposodesListModel {
                currentStation: page.station
            }

            delegate: Component {
                EpisodeListElement  {
                    id: episodeDelegate
                    onClicked: {
                        console.log("i am clicked: " + model.title);

                        var myUrl = Qt.resolvedUrl(model.enclosure);
                        console.log("myUrl: " + myUrl);
                        console.log("player source: " + player.source);
                        if (player.source.toString() === myUrl.toString()) {
                            console.log("same url");
                            if (player.playbackState === MediaPlayer.PlayingState) {
                                player.pause();
                                console.log("paused");
                            } else {
                                player.play();
                                console.log("play")
                            }
                        } else {
                            console.log("loading track: " + model.enclosure);
                            player.source = model.enclosure;
                            player.seek(0);
                            player.play();
                        }
                    }
                }
            }
            VerticalScrollDecorator {}
        }
    }
}
