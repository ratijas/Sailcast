/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import "../service"

/**
 * Abstract model representing list of `Station` objects, suitable for use as a `ListView.model` property.
 */
ListModel {
    property /*list<Station>*/var _stations: []
    property var _connections: []

    property int status: Component.Ready

    function stationAt(i) {
        return _stations[i];
    }

    function setStations(/*list<Station>*/ stations) {
        _stations.forEach(function(station, i) {
            station.statusChanged.disconnect(_connections[i]);
            station.destroy();
        })
        _connections = [];
        _stations = [];
        clear();

        stations.forEach(function(station, i) {
            var connection = _updateModelAt.bind(null, i);
            station.statusChanged.connect(connection);
            _connections.push(connection);
            _stations.push(station)
            append(_model(station));
        });
    }

    function _updateStatus() {
        for (var i = 0; i < _stations.length; i++) {
            if (_stations[i].status === Component.Loading) {
                status = Component.Loading;
                return;
            }
        }
        status = Component.Ready;
    }

    function _updateModelAt(i) {
        var station = _stations[i];
        set(i, _model(station));
        _updateStatus();
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
