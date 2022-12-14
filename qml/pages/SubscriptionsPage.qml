/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import "../model"
import "../view"

Page {
    id: root

    Component {
        id: searchPage
        SearchPage {}
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        StationsListView {
            id: subscriptionsListView

            clip: true

            header: PageHeader {
                title: qsTr("Subscriptions")
            }

            model: SubscriptionsListModel {
                id: subscriptionsModel
            }

            PullDownMenu {
                MenuItem {
                    text: qsTr("Update")
                    onClicked: subscriptionsModel.refresh()
                }
                quickSelect: true
                busy: subscriptionsModel.status === Component.Loading
            }
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
