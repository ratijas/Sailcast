import QtQuick 2.0
import Sailfish.Silica 1.0
import "../view"
import "../service"
import "../model"

Page {
    id: root

    property bool _firstRun: true

    onStatusChanged: {
        if (_firstRun && status === PageStatus.Active) {
            _firstRun = false;
            view.headerItem.forceActiveFocus();
        }
    }

    Dialog {
        id: addByRssUrlDialog

        canAccept: Qt.resolvedUrl(urlText.text).indexOf("http") === 0

        DialogHeader {
            acceptText: qsTr("Add")
        }
        TextField {
            id: urlText

            anchors {
                centerIn: parent
                leftMargin: Theme.horizontalPageMargin
                rightMargin: Theme.horizontalPageMargin
            }
            width: parent.width

            label: qsTr("RSS url")
            placeholderText: label
            EnterKey.enabled: addByRssUrlDialog.canAccept
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: addByRssUrlDialog.accept()

            text: "http://devzen.ru/feed/" // TODO: remove this
        }

        acceptDestination: Component {
            StationPage {
                station: Dao.emptyStation(this);
            }
        }
        onAcceptPendingChanged: {
            acceptDestinationInstance.station = Dao.stationFromUrl(acceptDestinationInstance, urlText.text);
        }
    }

    StationsListView {
        id: view

        anchors.fill: parent

        header: SearchField {
            width: parent.width

            placeholderText: qsTr("Search iTunes Store")

            EnterKey.enabled: text.length > 0
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: {
                focus = false;

                var query = text.trim();
                if (query === "") return;

                // do request to iTunes Store
                // pass callback
                var callback = function(results) {
                    // parse results, push parsed results into list model and refresh page
                    listModel.setStations(results.stations);
                };
                ITunes.search(query, callback);
            }

            onTextChanged: {
                if (text === "") {
                    listModel.clear();
                }
            }
        }

        // prevent newly added list delegates from stealing focus away from the search field
        currentIndex: -1

        model: StationsListModel {
            id: listModel
        }
    }

    ViewPlaceholder {
        enabled: listModel.count < 1
        Button {
            id: addByRssUrlBtn
            anchors.centerIn: parent
            text: qsTr("Add by RSS url")
            onClicked: pageStack.push(addByRssUrlDialog)
        }
    }
}
