import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {

    function newCoverId() {
        return "123";
    }

    Component.onCompleted: {
        var db = LocalStorage.openDatabaseSync("Podcasts", "1.0")
        db.transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS subscription (
                sb_station INTEGER PRIMARY KEY NOT NULL,
                sb_active INTEGER NOT NULL,
                sb_priority INTEGER NOT NULL,
                CONSTRAINT priority_unique UNIQUE (sb_priority)
            )");
            tx.executeSql("CREATE TABLE IF NOT EXISTS station (
                st_id INTEGER PRIMARY KEY NOT NULL,
                st_name TEXT NOT NULL,
                st_description TEXT,
                st_cover INT,
                st_feed_url TEXT NOT NULL
            )");
            tx.executeSql("CREATE TABLE IF NOT EXISTS episode (
                ep_id INTEGER PRIMARY KEY NOT NULL,
                ep_station INTEGER NOT NULL,
                ep_title TEXT NOT NULL,
                ep_description TEXT,
                ep_duration INTEGER NOT NULL,
                ep_guid TEXT,
                ep_cover INT,
                ep_date TEXT NOT NULL,
                ep_url TEXT NOT NULL,
                ep_playback_position INTEGER NOT NULL DEFAULT 0,
                ep_playback_status INTEGER NOT NULL DEFAULT 0
            )");
            tx.executeSql("CREATE TABLE IF NOT EXISTS cover (
                cv_id INTEGER PRIMARY KEY NOT NULL
            )");
            tx.executeSql("CREATE TABLE IF NOT EXISTS cover_size (
                cs_id INTEGER PRIMARY KEY NOT NULL,
                cs_cover INTEGER NOT NULL,
                cs_width INTEGER NOT NULL,
                cs_height INTEGER NOT NULL,
                CONSTRAINT unique_size UNIQUE (
                cs_cover,
                cs_width,
                cs_height
                ) ON CONFLICT REPLACE
            )");
            tx.executeSql("CREATE TABLE IF NOT EXISTS genres (
                gn_genre_id INTEGER NOT NULL,
                gn_station INTEGER NOT NULL
            )");
        });
        db.transaction(function(tx) {
            var results = tx.executeSql("insert into cover(cv_id) values (null)", []);
            var newCoverId = results.insertId;
        })
    }


    function subscriptions() {
        return [subscription(1, true)]
    }

    function subscription(id, active) {
        return {
            station: station_by_id(id),
            active: active
        }
    }

    function station_by_id(id) {
        return station(
                    id,
                    "Радио-Т",
                    "Подкаст выходного дня",
                    "http://www.radio-t.com/images/cover.jpg",
                    "http://feeds.feedburner.com/Radio-t"
                    )
    }

    function station(id, name, description, cover, feed_url) {
        return {
            id: id,
            name: name,
            description: description,
            cover: cover,
            feed_url: feed_url,
            episodes: episodes_by_station(id)
        }
    }

    function episodes_by_station(id) {
        return [episode_by_id(1), episode_by_id(2)]
    }

    function episode_by_id(id) {
        return {
            id: id,
            station: 1,
            title: "episode #" + id,
            description: "some text",
            date: Date.now(),
            url: "http://cdn.radio-t.com/rt_podcast539.mp3"
        }
    }
}
