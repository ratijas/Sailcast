/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

pragma Singleton
import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "../model"

Item {
    property string dbName: "SailcastDatabase"
    property var database

    // is a hack / workaround for Connections {}
    property QtObject self: this

    /**
     * This signal is fired whenever user subscribes to or unsubscribes from a station.
     *
     * This signal contains unique `feed_url` of a Station for which an action was performed;
     * and boolean flag `subscribed` which is set to `true` when if the user have just
     * subscribed to a Station and `false` otherwise.
     *
     * This should be used in conjunction with asynchronous method `isSubscribed`.
     */
    signal subscription(string feed_url, bool subscribed)

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
                subscription(url, true);
            }
            mock("http://feeds.rucast.net/radio-t", 1);
            mock("http://feeds.feedburner.com/razbor-podcast", 2);
            mock("http://aerostat.podfm.ru/aerostat/rss/rss.xml", 3);

            console.log("Dao: database initialized");
        });
    }

    /**
     * Load list of user's favorite stations for start page.
     *
     * @param callback(list<Station>)
     */
    function subscriptions(parent, callback) {
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
                var station = stationFromUrl(parent, row.feed_url);
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
        subscription(feed_url, true);
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
        });
        subscription(feed_url, false);
    }

    /**
     * Check wether a user is subscribed to a station with url `feed_url`.
     * This function is async, so execution will continue with `callback`.
     *
     * @param callback continuation function of one argument -- boolean result of this check.
     */
    function isSubscribed(feed_url, callback) {
        var result = false;
        database = LocalStorage.openDatabaseSync(dbName, "1.0")
        database.transaction(function(tx) {
            var cursor = tx.executeSql("
                SELECT *
                FROM subscriptions
                WHERE feed_url = ?
            ", [feed_url]);
            result = cursor.rows.length === 1;
        });
        callback(result);
    }

    Component {
        id: stationComponent
        Station {}
    }

    /**
     * Create new `Station` object from given RSS feed URL.
     */
    function stationFromUrl(parent, feed_url) {
        console.log("Dao: creating station from url:", feed_url);
        return stationComponent.createObject(parent, {feed_url: feed_url});
    }

    /**
     * Create empty `Station` object without any data.
     */
    function emptyStation(parent) {
        return stationComponent.createObject(parent);
    }
}
