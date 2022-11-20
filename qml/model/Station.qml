/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Item {
    id: root

    property string title
    property string description
    property url cover
    property url feed_url
    property var episodes: []
    property bool _stationLoaded: false
    property bool _episodesLoaded: false

    property var _request

    property int status: Component.Null

    Component.onCompleted: {
        feed_urlChanged.connect(reload);
        reload();
    }

    function reload() {
        if (!feed_url) return;

        status = Component.Loading;
        _stationLoaded = false;
        _episodesLoaded = false;

        _request = new XMLHttpRequest();
        _request.onreadystatechange = _readyStateChangeHandler;
        _request.onerror = _errorHandler;
        _request.timeout = 60;
        _request.open("GET", feed_url);
        _request.send();
    }

    function _readyStateChangeHandler() {
        if (_request.readyState === XMLHttpRequest.DONE) {
            if (_request.status === 200) {
                stationModel.xml = _request.responseText;
                stationModel.reload();
                episodesModel.xml = _request.responseText;
                episodesModel.reload();
            } else {
                _errorHandler();
            }
        }
    }

    XmlListModel {
        id: stationModel
        onStatusChanged: {
            if (stationModel.status === XmlListModel.Ready) {
                _extractStation();
            } else if (stationModel.status === XmlListModel.Error) {
                _errorHandler();
            }
        }

        query: "/rss/channel"

        XmlRole {
            name: "title"
            query: "title/string()"
        }

        XmlRole {
            name: "description"
            query: "description/string()"
        }

        XmlRole {
            name: "cover"
            query: "*[name()='itunes:image']/@href/string()"
        }
    }

    XmlListModel {
        id: episodesModel

        onStatusChanged: {
            if (episodesModel.status === XmlListModel.Ready) {
                _extractEpisodes();
            } else if (episodesModel.status === XmlListModel.Error) {
                _errorHandler();
            }
        }

        query: "/rss/channel/item"

        XmlRole {
            name: "title"
            query: "title/string()"
        }

        XmlRole {
            name: "description"
            query: "description/string()"
        }

        XmlRole {
            name: "cover"
            query: "*[name()='itunes:image']/@href/string()"
        }

        XmlRole {
            name: "enclosure"
            query: "enclosure/@url/string()"
        }

        XmlRole {
            name: "pubDate"
            query: "pubDate/string()"
        }
    }

    function _extractStation() {
        if (stationModel.count === 1) {
            var model = stationModel.get(0);

            title = model.title;
            description = model.description;
            if (cover.toString() === "") {
                cover = model.cover;
            }

            _stationLoaded = true;
            _checkStatusReady();

        } else {
            _errorHandler();
        }
    }

    function _extractEpisodes() {
        if (episodesModel.count !== 0) {
            episodes = []
            for (var i = 0; i < episodesModel.count; i++) {
                var episodeModel = episodesModel.get(i);

                if (episodeModel.enclosure) {
                    episodes.push(_extractEpisode(episodeModel));
                }
            }
            _episodesLoaded = true;
            _checkStatusReady();
        } else {
            _errorHandler();
        }
    }

    function _extractEpisode(model) {
        var episode = episodeFromRawParts(
            model.title,
            model.description,
            model.cover,
            model.enclosure,
            model.pubDate
        );
        return episode;
    }

    Component {
        id: episodeComponent
        Episode {}
    }

    function episodeFromRawParts(title, description, cover, enclosure, pubDate) {
        return episodeComponent.createObject(root, {
            station: root,
            title: title,
            description: description,
            ownCover: (cover !== ""),
            cover: Qt.binding(function() {
                return this.ownCover ? cover : root.cover;
            }),
            enclosure: enclosure,
            pubDate: pubDate
        });
    }

    function _checkStatusReady() {
        if (_stationLoaded && _episodesLoaded) {
            status = Component.Ready;
        }
    }

    function _errorHandler() {
        status = Component.Error;
    }
}
