import QtQuick 2.0
import "../service"

/**
 * Abstract model representing list of `Station` objects, suitable for use as a `ListView.model` property.
 */
ListModel {

    /**
     * List of `Station` objects.  After altering this list, call `updateModel`
     * method so that changes could be reflected in the ListModel.
     */
    property var stations: []

    id: model

    function updateModel() {
        console.log("StationsListModel: updating model, total = " + stations.length);

        clear();

        stations.forEach(function(station) {
            station.statusChanged.connect(updateModel);
            append({
                       status:      station.status,
                       title:       station.title,
                       description: station.description,
                       cover:       station.cover.toString(),
                       feed_url:    station.feed_url.toString(),
                       episodesCount: station.episodes.length,
                   });
        });
    }
}
