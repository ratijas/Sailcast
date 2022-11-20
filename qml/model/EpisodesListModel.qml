import QtQuick 2.0
import "../service"

ListModel {
    property var station

    Component.onCompleted: {
        stationChanged.connect(refresh);
        refresh();
    }

    function refresh() {
        station.statusChanged.connect(updateModel);
        updateModel();
    }

    function updateModel() {
        console.log("EpisodesListModel: updating model, total", station.episodes.length);

        clear();
        for (var i = 0; i < station.episodes.length; i++) {
            var episode = station.episodes[i];
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
