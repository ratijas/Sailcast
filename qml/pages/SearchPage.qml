import QtQuick 2.0
import Sailfish.Silica 1.0
import "../view"
import "../service"
import "../model"

Page {
    id: page

    StationsListView {
        id: view

        anchors.fill: parent

        header: SearchField {
            width: parent.width
            placeholderText: "Search iTunes Store"
            onTextChanged: {
                listModel.updateModel();
            }
        }

        // prevent newly added list delegates from stealing focus away from the search field
        currentIndex: -1

        model: MyStationsListModel {
            id: listModel

            function updateModel() {
                clear();
                var searchField = view.headerItem;
                for (var i = 0; i < stations.length; i++) {
                    var station = stations[i];
                    if (searchField.text === "" || stations[i].title.indexOf(searchField.text) >= 0) {
                        console.log("updateModel: station = " + station);
                        append({
                                   status:      station.status,
                                   title:       station.title,
                                   description: station.description,
                                   cover:       station.cover.toString(),
                                   feed_url:    station.feed_url,
                                   episodesCount: station.episodes.length,
                               });
                    }
                }
            }
        }
    }
}
