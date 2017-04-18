import QtQuick 2.0
import "../service"

ListModel {
    property var currentStation
    property var episodes: []

    Component.onCompleted: {
        refresh();
    }

    function refresh() {
        for (var i = 0; i < currentStation.episodes.length; i++) {
            currentStation.statusChanged.connect(updateModel);
        }
        updateModel();

    }

    function updateModel() {
        console.log("MyEpisodesListModel: updating model, total = " + currentStation.episodes.length);

        clear();
        for (var i = 0; i < currentStation.episodes.length; i++) {
            var episode = currentStation.episodes[i];
            append({
                       //status:      station.status,
//                       title:       station.title,
//                       description: station.description,
//                       cover:       station.cover.toString(),
//                       feed_url:    station.feed_url,
//                       episodesCount: station.episodes.length,

                       station: episode.station,
                       title: episode.title,
                       description: episode.description,
                       cover: episode.cover,
                       enclosure: episode.enclosure,
                       pubDate: episode.pubDate
                   });
        }
    }
}
