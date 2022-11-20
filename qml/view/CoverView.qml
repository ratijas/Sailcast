/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: view

    property url cover
    property alias status: coverImage.status
    property bool highlighted: false

    states: [
        State {
            name: "loading"
            when: view.status === Image.Loading
            PropertyChanges {
                target: coverImage
                opacity: 0
            }
        },
        State {
            name: "ready"
            when: view.status === Image.Ready
            PropertyChanges {
                target: coverImage
                opacity: 1
            }
            PropertyChanges {
                target: coverDefault
                opacity: 0
            }
        },
        State {
            name: "error"
            when: view.status === Image.Error
            PropertyChanges {
                target: coverImage
                opacity: 0
            }
            PropertyChanges {
                target: coverDefault
                opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            to: "loading"

            NumberAnimation {
                target: coverImage
                property: "opacity"
                duration: 0
            }
        },
        Transition {
            NumberAnimation {
                targets: [coverImage, coverDefault]
                property: "opacity"
                duration: 2000
                easing.type: Easing.InOutQuad
            }
        }
    ]

    Image {
        id: coverImage

        fillMode: {
            var max = Math.max(sourceSize.height, sourceSize.width);
            var min = Math.min(sourceSize.height, sourceSize.width);

            return ((max - min) / min) < 0.1
                    ? Image.PreserveAspectCrop
                    : Image.PreserveAspectFit;
        }
        anchors.fill: view

        source: view.cover

        opacity: 1
    }

    BusyIndicator {
        anchors.centerIn: view

        size: Math.min(view.height, view.width) <= Theme.iconSizeLarge
                ? BusyIndicatorSize.Medium :
                  BusyIndicatorSize.Large
        running: (view.cover.toString() !== "") && (status !== Image.Error) && (status !== Image.Ready)
    }

    // in case station's cover can not be loaded
    Image {
        id: coverDefault

        anchors.fill: view

        // TODO: add default podcast cover
        source: ("image://theme/icon-l-play?" +
                 (highlighted
                  ? Theme.highlightColor
                  : Theme.primaryColor))

        opacity: 1
    }
}
