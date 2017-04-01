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

Page {
    //property string podcastUrl:"http://n5.radio-t.com/rtfiles/rt_podcast539.mp3"
    id: page
    MediaPlayer {

        id: player
        //source: podcastUrl

    }
    ListModel {
        id: podcastModel

        ListElement {
            sequence: "Радио-Т 538"
            duration: 600
            title:"Как написать Commit Message"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast538.mp3"
            cover:"https://radio-t.com/images/radio-t/rt538.jpg"
            played_position:60
            playback_status:1

        }
        ListElement {
            sequence: "Радио-Т 539"
            duration: 1200
            title:"Матрица переходов2"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast539.mp3"
            cover:"https://radio-t.com/images/radio-t/rt539.jpg"
            played_position:10
            playback_status:1

        } ListElement {
            sequence: "Радио-Т 540"
            duration: 600
            title:"Матрица переходов3"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast537.mp3"
            cover:"https://radio-t.com/images/radio-t/rt537.jpg"
            played_position:0
            playback_status:2

        }
        ListElement {
            sequence: "Радио-Т 538"
            duration: 600
            title:"Как написать Commit Message"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast538.mp3"
            cover:"https://radio-t.com/images/radio-t/rt538.jpg"
            played_position:60
            playback_status:1

        }
        ListElement {
            sequence: "Радио-Т 539"
            duration: 1200
            title:"Матрица переходов2"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast539.mp3"
            cover:"https://radio-t.com/images/radio-t/rt539.jpg"
            played_position:10
            playback_status:1

        } ListElement {
            sequence: "Радио-Т 540"
            duration: 600
            title:"Матрица переходов3"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast537.mp3"
            cover:"https://radio-t.com/images/radio-t/rt537.jpg"
            played_position:0
            playback_status:2

        }
        ListElement {
            sequence: "Радио-Т 538"
            duration: 600
            title:"Как написать Commit Message"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast538.mp3"
            cover:"https://radio-t.com/images/radio-t/rt538.jpg"
            played_position:60
            playback_status:1

        }
        ListElement {
            sequence: "Радио-Т 539"
            duration: 1200
            title:"Матрица переходов2"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast539.mp3"
            cover:"https://radio-t.com/images/radio-t/rt539.jpg"
            played_position:10
            playback_status:1

        } ListElement {
            sequence: "Радио-Т 540"
            duration: 600
            title:"Матрица переходов3"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast537.mp3"
            cover:"https://radio-t.com/images/radio-t/rt537.jpg"
            played_position:0
            playback_status:2

        }
        ListElement {
            sequence: "Радио-Т 538"
            duration: 600
            title:"Как написать Commit Message"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast538.mp3"
            cover:"https://radio-t.com/images/radio-t/rt538.jpg"
            played_position:60
            playback_status:1

        }
        ListElement {
            sequence: "Радио-Т 539"
            duration: 1200
            title:"Матрица переходов2"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast539.mp3"
            cover:"https://radio-t.com/images/radio-t/rt539.jpg"
            played_position:10
            playback_status:1

        } ListElement {
            sequence: "Радио-Т 540"
            duration: 600
            title:"Матрица переходов3"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast537.mp3"
            cover:"https://radio-t.com/images/radio-t/rt537.jpg"
            played_position:0
            playback_status:2

        }
        ListElement {
            sequence: "Радио-Т 538"
            duration: 600
            title:"Как написать Commit Message"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast538.mp3"
            cover:"https://radio-t.com/images/radio-t/rt538.jpg"
            played_position:60
            playback_status:1

        }
        ListElement {
            sequence: "Радио-Т 539"
            duration: 1200
            title:"Матрица переходов2"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast539.mp3"
            cover:"https://radio-t.com/images/radio-t/rt539.jpg"
            played_position:10
            playback_status:1

        } ListElement {
            sequence: "Радио-Т 540"
            duration: 600
            title:"Матрица переходов3"
            url:"http://n5.radio-t.com/rtfiles/rt_podcast537.mp3"
            cover:"https://radio-t.com/images/radio-t/rt537.jpg"
            played_position:0
            playback_status:2

        }
    }


    SilicaListView {
        id: listView
        model: podcastModel
        y:350
        height: parent.height-200
        width: parent.width

        delegate: BackgroundItem {
            id: delegate
            Item{
                width:listView.width
                height: 150
                Column{
                    anchors.left:parent.left
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    Label {
                        text: qsTr(title)
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                    Label {
                        text: qsTr("30 minutes")
                        font.pixelSize: Theme.fontSizeSmall/2
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                }
                IconButton{
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter
                    icon.source: "image://theme/icon-m-" + (pressed ? "pause" : "play")
                    onClicked: if (player.playbackState == MediaPlayer.PlayingState) {
                                   player.pause();
                               } else {
                                   player.source=url
                                   player.play();
                               }
                }
            }

        }
        VerticalScrollDecorator {}
    }
    Row{
        x: Theme.paddingLarge
        y: Theme.paddingLarge
        height: 200
        width: parent.width
        Image {
            id:stationCover
            source: "http://www.radio-t.com/images/cover.jpg"
            width: parent.height
            height:parent.height
        }
        Column{
            height:parent.height
            width: parent.width-stationCover.width-2*Theme.paddingLarge
            //width: 400
            Label {
                id:stationLabel
                x: Theme.horizontalPageMargin
                text: qsTr("Радио-Т")
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.primaryColor
            }
            TextArea {
                text: qsTr(" Еженедельные импровизации на хай–тек темы Еженедельные импровизации на хай–тек темы")
                color: Theme.primaryColor
                //width: parent.width-station.width- 3*Theme.horizontalPageMargin
                width: parent.width
                height:parent.height
                readOnly:true
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: TextEdit.WordWrap
            }
        }
    }
}
