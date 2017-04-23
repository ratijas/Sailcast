import QtQuick 2.0
import Sailfish.Silica 1.0
import "../view"
import "../service"
import "../model"

Page {
    id: root

    Dialog {
        id: addByRssUrlDialog

        canAccept: Qt.resolvedUrl(urlText.text).indexOf("http") === 0

        DialogHeader {
            acceptText: "Add"
        }
        TextField {
            id: urlText

            anchors {
                centerIn: parent
                leftMargin: Theme.horizontalPageMargin
                right: Theme.horizontalPageMargin
            }
            width: parent.width

            label: qsTr("RSS url")
            placeholderText: label

            text: "http://feeds.rucast.net/radio-t" // TODO: remove this
        }

        acceptDestination: Component {
            StationPage {
                station: Dao.emptyStation()
            }
        }
        onAcceptPendingChanged: {
            acceptDestinationInstance.station = Dao.stationFromUrl(urlText.text);
        }
    }

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

            property var displayedStations: []

            function updateModel() {
                clear();
                displayedStations = [];
                var searchField = view.headerItem;
                for (var i = 0; i < stations.length; i++) {
                    var station = stations[i];
                    if (searchField.text === "" || stations[i].title.indexOf(searchField.text) >= 0) {
                        console.log("updateModel: station = " + station);
                        displayedStations.push(station);
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

            function getStation(index) {
                return displayedStations[index];
            }
        }
    }

    Button {
        id: addByRssUrlBtn
        visible: listModel.count < 1
        anchors.centerIn: root
        text:"Add by RSS url"
        onClicked: pageStack.push(addByRssUrlDialog)
    }
}
