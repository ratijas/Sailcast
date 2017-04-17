import QtQuick 2.0
import Sailfish.Silica 1.0
import "../model"
import "../view"

Page {
    id: root
    SilicaListView {
        id: view
        anchors.fill: root

        model: MyStationsListModel {
            id: model
        }

        delegate: Component {
            StationListElement {
                id: delegate
            }
        }
        VerticalScrollDecorator {}
    }
}
