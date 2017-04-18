pragma Singleton
import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "../model"

Item {

    property string dbName: "SailcastDatabase"
    property var database

    signal subscribtion(string feed_url, bool subscribed)

    Component.onCompleted: {
        database = LocalStorage.openDatabaseSync(dbName, "1.0");
        database.transaction(function(tx) {
            tx.executeSql("
                CREATE TABLE IF NOT EXISTS subscriptions(
                    feed_url TEXT    UNIQUE                    NOT NULL,
                    position INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
                )");

            // XXX: exists solely for testing purposes
            function mock(url, id) {
                tx.executeSql("
                        INSERT OR IGNORE
                        INTO subscriptions(feed_url, position)
                        VALUES(?, ?)
                ", [url, id]);
                subscribtion(url, true);
            }
            mock("http://feeds.rucast.net/radio-t", 1);
            mock("http://feeds.feedburner.com/razbor-podcast", 2);
            mock("http://aerostatica.ru/podcast.xml", 3);

            console.log("Dao: database initialized");
        });
    }

    /**
     * Load list of user's favorite stations for start page.
     *
     * @param callback(list<Station>)
     */
    function subscriptions(callback) {
        database = LocalStorage.openDatabaseSync(dbName, "1.0");
        database.transaction(function(tx) {
            var cursor = tx.executeSql("
                SELECT feed_url
                FROM subscriptions
                ORDER BY position DESC
            ");
            var rows = cursor.rows;
            console.log("Dao: fetching subscriptions: total = " + rows.length);

            var results = [];
            for (var i = 0; i < rows.length; i++) {

                var row = rows.item(i);
                var station = stationFromUrl(row.feed_url);
                results.push(station);
            }

            console.log("Dao: subscriptions as Station objects: " + results);
            callback(results);
        });
    }

    /**
     * Subscribe to a station by its unique `feed_url`.
     */
    function subscribe(feed_url) {
        database = LocalStorage.openDatabaseSync(dbName, "1.0");
        database.transaction(function(tx) {
            tx.executeSql("
                INSERT INTO subscriptions(feed_url)
                VALUES(?)
            ", [feed_url]);
        });
        subscribtion(feed_url, true);
    }

    /**
     * Unsubscribe from a station by its unique `feed_url`.
     */
    function unsubscribe(feed_url) {
        database = LocalStorage.openDatabaseSync(dbName, "1.0")
        database.transaction(function(tx) {
            tx.executeSql("
                DELETE FROM subscriptions
                WHERE feed_url = ?
            ", [feed_url]);
            subscribtion(feed_url, false);
        });
    }

    /**
     * Check wether a user is subscribed to a station with url `feed_url`.
     * This function is async, so execution will continue with `callback`.
     *
     * @param callback continuation function of one argument -- boolean result of this check.
     */
    function isSubscribed(feed_url, callback) {
        database = LocalStorage.openDatabaseSync(dbName, "1.0")
        database.transaction(function(tx) {
            var cursor = tx.executeSql("
                SELECT *
                FROM subscriptions
                WHERE feed_url = ?
            ", [feed_url]);
            var result = cursor.rows.length === 1;
            callback(result);
        });
    }

    Component {
        id: _stationComponent
        Station {}
    }

    /**
     * Create new `Station` object from given RSS feed URL.
     */
    function stationFromUrl(feed_url) {
        console.log("Dao: creating station from url: " + feed_url);
        return _stationComponent.createObject(null, {feed_url: feed_url});
    }
}
