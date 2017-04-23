import QtQuick 2.0
import Sailfish.Silica 1.0
import "../view"
import "../service"
import "../model"

Page {
    id: root

    onStatusChanged: {
        if (status === PageStatus.Active) {
            view.headerItem.forceActiveFocus();
        }
    }

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
                rightMargin: Theme.horizontalPageMargin
            }
            width: parent.width

            label: qsTr("RSS url")
            placeholderText: label

            text: "http://devzen.ru/feed/" // TODO: remove this
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

            placeholderText: qsTr("Search iTunes Store")

            EnterKey.onClicked: {
                focus = false;

                var query = text.trim();
                if (query === "") return;

                // do request to iTunes Store
                // pass callback
                var callback = function(results) {
                    // parse results
                    // push parsed results into list model
                    listModel.stations = results;
                    // refresh page
                    listModel.updateModel();
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

    Button {
        id: addByRssUrlBtn
        visible: listModel.count < 1
        anchors.centerIn: root
        text:"Add by RSS url"
        onClicked: pageStack.push(addByRssUrlDialog)
    }
}
