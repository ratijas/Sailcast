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
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "../model"
import "../view"

Page {
    property var station
    id: stationPage
    SilicaListView {
        id: listView
        model: MyEposodesListModel {
            currentStation: station
        }

        //        model: MyEposodesListModel {
        //           id: episodes
        //           currentStation:station
        //        }
        y:350
        height: parent.height-200
        width: parent.width

        delegate: Component {
            EpisodeListElement  {
                id: episodeDelegate
                onClicked: {
                    console.log("i am clicked: " + model.title);
                    console.log("url: " + model.enclosure.toString());
                    if (player.playbackState === MediaPlayer.PlayingState) {
                        player.pause();
                    } else {
                        player.source = model.enclosure.toString()
                        player.play();
                    }
                    console.log("player's status: " + player.playbackState.toString());
                }
            }

        }
        VerticalScrollDecorator {}
    }
    //    Component {
    //        StationHeader{
    //            id:stationHeader
    //            Component.onCompleted: {
    //                console.log("StationHeader: pushed.")
    //            }
    //        }
    //    }
    Row{
        x: Theme.paddingLarge
        y: Theme.paddingLarge
        height: 200
        width: parent.width
        Image {
            id:stationCover
            source: station.cover
            width: parent.height
            height:parent.height
        }
        Column{
            height:parent.height
            width: parent.width-stationCover.width-2*Theme.paddingLarge
            Label {
                id:stationLabel
                x: Theme.horizontalPageMargin
                text: station.title
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.primaryColor
            }
            TextArea {
                text: station.description
                color: Theme.primaryColor
                width: parent.width
                height:parent.height
                readOnly:true
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: TextEdit.WordWrap
            }
        }
    }

}
