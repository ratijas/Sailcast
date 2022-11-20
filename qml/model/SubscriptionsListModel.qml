/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import "../service"

StationsListModel {

    Component.onCompleted: {
        Dao.subscription.connect(function(feed_url, subscribed) {
            refresh();
        });
        refresh();
    }

    function refresh() {
        Dao.subscriptions(this, function(subscriptions) {
            setStations(subscriptions);
        });
    }
}
