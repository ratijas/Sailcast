import QtQuick 2.0
import "../service"

StationsListModel {

    Component.onCompleted: {
        refresh();
        Dao.subscription.connect(refresh);
    }

    function refresh() {
        Dao.subscriptions(function(subscriptions) {
            stations = subscriptions;
            updateModel();
        });
    }
}
