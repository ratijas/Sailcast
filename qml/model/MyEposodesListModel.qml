import QtQuick 2.0
import "../service"

ListModel {
    property var currentStation

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
                       station: episode.station,
                       title: episode.title,
                       description: episode.description,
                       cover: episode.cover.toString(),
                       enclosure: episode.enclosure.toString(),
                       pubDate: episode.pubDate
                   });
        }
    }
}
