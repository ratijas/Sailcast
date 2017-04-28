import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    property url cover
    property alias status: coverImage.status
    property bool highlighted: false

    id: view

    states: [
        State {
            name: "loading"
            when: status === Image.Loading
            PropertyChanges {
                target: coverImage
                opacity: 0
            }
        },
        State {
            name: "ready"
            when: status === Image.Ready
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
            when: status === Image.Error
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

        fillMode: Image.PreserveAspectCrop
        anchors.fill: view

        source: view.cover ? view.cover : Qt.resolvedUrl()

        opacity: 1
    }

    BusyIndicator {
        anchors.centerIn: view

        size: Math.min(view.height, view.width) <= Theme.iconSizeLarge
                ? BusyIndicatorSize.Medium :
                  BusyIndicatorSize.Large
        running: (view.cover != "") && (status !== Image.Error) && (status !== Image.Ready)
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
