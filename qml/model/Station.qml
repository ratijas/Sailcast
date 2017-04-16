import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import QtWebKit 3.0

Item {
    property string title
    property string description
    property url cover : ""
    property url feed_url

    property var _request

    property int status: Component.Null

    Component.onCompleted: {
        console.log("Station: Component.onCompleted, feed_url = " + feed_url);
        reload();
    }

    function reload() {
        status = Component.Loading;

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

                _xmlModel.xml = _request.responseText;
            } else {
                status = Component.Error;
            }
        }
    }

    XmlListModel {
        id:  _xmlModel
        onStatusChanged: {
            if (_xmlModel.status === XmlListModel.Ready) {
                _extract();
            } else if (_xmlModel.status === XmlListModel.Error) {
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

    function _extract() {
        if (_xmlModel.count === 1) {
            var model = _xmlModel.get(0);

            title = model.title;
            description = model.description;
            cover = model.cover;

            status = Component.Ready;

        } else {
            _errorHandler();
        }
    }

    function _errorHandler() {
        status = Component.Error;
    }
}
