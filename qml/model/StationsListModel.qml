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

    function updateModel() {
        clear();

        stations.forEach(function(station, i) {
            station.statusChanged.connect(updateModelAt.bind(null, i));
            append(_model(station));
        });
    }

    /**
     * Optimized version of `updateModel`.
     */
    function updateModelAt(i) {
        var station = stations[i];
        set(i, _model(station));
    }

    function _model(station) {
        return {
            status:        station.status,
            title:         station.title,
            description:   station.description,
            cover:         station.cover.toString(),
            feed_url:      station.feed_url.toString(),
            episodesCount: station.episodes.length
        };
    }
}
