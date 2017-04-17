import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import "../model"
import "../view"

Page {
    id: root

    Component {
        id: stationPage
        StationPage {}
    }

    Component {
        id: searchPage
        SearchPage {}
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        SilicaListView {
            id: view
            Layout.fillHeight: true
            Layout.fillWidth: true

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

        BackgroundItem {
            id: search
            Row {
                anchors.fill: parent
                anchors.rightMargin: Theme.horizontalPageMargin
                spacing: Theme.paddingMedium
                Item {
                    width: Theme.iconSizeLarge
                    height: Theme.iconSizeLarge
                    anchors.verticalCenter: parent.verticalCenter
                    Image {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        source: "image://theme/icon-m-search"
                    }
                }

                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Search / Add RSS")
                }
            }
            onClicked: {
                pageStack.push(searchPage)
            }
        }
    }
}
