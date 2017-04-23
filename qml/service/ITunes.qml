pragma Singleton
import QtQuick 2.0
import "../model"

QtObject {
    /**
     * Search iTunes podcasts using iTunes Search API.
     *
     * @param query    Query string.
     * @param callback Function to be called when results are ready. It takes one argument: SearchResult object.
     *
     */
    function search(query, callback) {
        var component = Qt.createComponent("SearchResult.qml");
        var result = component.createObject();

        result.query = query;
        result.status = Component.Loading;

        callback(result);
    }
}
