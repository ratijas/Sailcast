import QtQuick 2.0
import Sailfish.Silica 1.0
import "../model"
import "../view"

Page {
    id: root
    Component {
        id: stationPage
        StationPage {}
    }

    SilicaListView {
        id: view
        anchors.fill: root

        model: MyStationsListModel {
            id: stations
        }

        delegate: Component {
            StationListElement {
                id: delegate
                onClicked: {
                    console.log("i am clicked: " + model.title);
                    var page = stationPage.createObject(root, {station: stations.stations[index]});
                    pageStack.push(page);
                }
            }
        }
        VerticalScrollDecorator {}
    }
}
