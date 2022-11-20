/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import "../pages"

BackgroundItem {
    id: element

    width: parent.width
    height: Theme.iconSizeLarge

    RowLayout {
        anchors.fill: parent
        spacing: Theme.paddingMedium

        CoverView {
            Layout.minimumWidth: parent.height
            Layout.preferredWidth: parent.height
            Layout.maximumWidth: parent.height
            Layout.minimumHeight: parent.height

            cover: model.cover
            highlighted: element.highlighted
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Label {
                id: title

                Layout.fillWidth: true

                text: model.title ? model.title : qsTr("Loading...")

                color: element.highlighted ? Theme.highlightColor : Theme.primaryColor
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Theme.fontSizeLarge
                elide: Text.ElideRight
            }

            Text {
                id: episodesCount

                Layout.fillWidth: true

                text: qsTr("Episodes: ") + model.episodesCount

                color: element.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
            }
        }
    }
}
