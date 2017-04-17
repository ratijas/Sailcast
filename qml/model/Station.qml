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
        console.log("Station: Component.onCompleted, feed_url = " + feed_url);
        reload();
    }

    function reload() {
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
        console.log("Station: readyState = " + _request.readyState);
        if (_request.readyState === XMLHttpRequest.DONE) {

            console.log("Station: status = " + _request.status);
            if (_request.status === 200) {

                console.log("Station: actually, status = DONE");

                _stationModel.xml = _request.responseText;
                _episodesModel.xml = _request.responseText;
            } else {
                _errorHandler()
            }
        }
    }

    XmlListModel {
        id:  _stationModel
        onStatusChanged: {
            if (_stationModel.status === XmlListModel.Ready) {
                _extractStation();
            } else if (_stationModel.status === XmlListModel.Error) {
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
        id:  _episodesModel

        onStatusChanged: {
            if (_episodesModel.status === XmlListModel.Ready) {
                _extractEpisodes();
            } else if (_episodesModel.status === XmlListModel.Error) {
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
        if (_stationModel.count === 1) {
            var model = _stationModel.get(0);

            title = model.title;
            description = model.description;
            cover = model.cover;

            _stationLoaded = true;
            _checkStatusReady();

        } else {
            _errorHandler();
        }
    }

    function _extractEpisodes() {
        if (_episodesModel.count !== 0) {
            episodes = []
            for (var i = 0; i < _episodesModel.count; i++) {
                var episodeModel = _episodesModel.get(i);

                episodes.push(_extractEpisode(episodeModel));
            }
            _episodesLoaded = true;
            _checkStatusReady();
        } else {
            _errorHandler();
        }
        console.log("_extractEpisodes: extracted total " + episodes.length + " episodes");
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
        id: _episodeComponent
        Episode {}
    }

    function episodeFromRawParts(title, description, cover, enclosure, pubDate) {
        console.log("Dao: creating episode from raw parts");
        return _episodeComponent.createObject(root,
                                              {
                                                  station: root,
                                                  title: title,
                                                  description: description,
                                                  cover: cover,
                                                  enclosure: enclosure,
                                                  pubDate: pubDate,
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
