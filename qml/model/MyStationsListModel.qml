import QtQuick 2.0
import "../service"

ListModel {

    property var stations: []

    Component.onCompleted: {
        refresh();
    }

    function refresh() {
        Dao.subscriptions(function(subscriptions) {
            stations = subscriptions;

            for (var i = 0; i < stations.length; i++) {
                var station = stations[i];
                station.statusChanged.connect(updateModel);
            }
        });
    }

    function updateModel() {
        console.log("MyStationsListModel: updating model, total = " + stations.length);

        clear();
        for (var i = 0; i < stations.length; i++) {
            var station = stations[i];
            append({
                       status:      station.status,
                       title:       station.title,
                       description: station.description,
                       cover:       station.cover.toString(),
                       feed_url:    station.feed_url,
                   });
        }
    }
}
