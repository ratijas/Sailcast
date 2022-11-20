pragma Singleton
import QtQuick 2.0
import "../model"
import "../service"

Item {

    /**
     * Search iTunes podcasts using iTunes Search API.
     *
     * @param query    Query string.
     * @param callback Function to be called when results are ready. It takes one argument: SearchResult object.
     *
     */
    function search(query, callback) {
        var BASE_URL = "https://itunes.apple.com/search?media=podcast&term=";

        var result = searchResult.createObject();

        result.query = query;
        result.status = Component.Loading;

        var url = BASE_URL + encodeURIComponent(query);

        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var json = JSON.parse(xhr.responseText);
                    parse(result, json);
                    result.status = Component.Ready;
                    callback(result);
                } else {
                    console.log("iTunes request error: HTTP:", xhr.status, xhr.statusText);
                    result.status = Component.Error;
                    result.error = xhr.responseText;
                    callback(result);
                }
            }
        };
        xhr.timeout = 60;
        xhr.open("GET", url);
        xhr.send();
    }

    Component {
        id: searchResult
        SearchResult {}
    }

    /**
     * @param result `SearchResult` object.
     * @param json   Raw json object returned by iTunes Search API.
     */
    function parse(result, json) {
        var results = json["results"];
        results.forEach(function(item) {
            var station = Dao.stationFromUrl(result, item["feedUrl"]);
            station.title = item["trackName"];
            station.cover = item["artworkUrl100"] || "";
            result.stations.push(station);
        });
    }
}
