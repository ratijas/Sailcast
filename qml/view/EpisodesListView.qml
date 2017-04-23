import QtQuick 2.0
import QtMultimedia 5.0
import Sailfish.Silica 1.0
import "../model"
import "../view"
import "../service"

SilicaListView {
    /**
     * `Station`'s object episodes will be displayed in this ListView.
     */
    property var station

    id: view

    clip: true

    model: EpisodesListModel {
        station: view.station
    }

    delegate: Component {
        EpisodeListElement  {
            id: delegate
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