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

        Item {
            id: cover

            Layout.minimumWidth: parent.height
            Layout.preferredWidth: parent.height
            Layout.maximumWidth: parent.height
            Layout.minimumHeight: parent.height

            states: [
                State {
                    name: "coverLoading"
                    when: coverImage.status === Image.Loading
                    PropertyChanges {
                        target: coverImage
                        opacity: 0
                    }
                },
                State {
                    name: "coverReady"
                    when: coverImage.status === Image.Ready
                    PropertyChanges {
                        target: coverImage
                        opacity: 1
                    }
                },
                State {
                    name: "coverError"
                    when: coverImage.status === Image.Error || element.state === "stationError"
                    PropertyChanges {
                        target: coverDefault
                        opacity: 1
                    }
                }
            ]

            transitions: Transition {
                NumberAnimation {
                    targets: [coverImage]
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 2000
                    easing.type: Easing.InOutQuad
                }

                NumberAnimation {
                    targets: [coverDefault]
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 2000
                    easing.type: Easing.InOutQuad
                }
            }

            Image {
                id: coverImage
                fillMode: Image.PreserveAspectCrop
                anchors.fill: cover

                source: model.cover

                opacity: 1
            }

            // in case station's cover can not be loaded
            Image {
                id: coverDefault
                anchors.centerIn: cover

                // TODO: add default podcast cover
                source: ("image://theme/icon-l-play?" +
                         (element.highlighted
                          ? Theme.highlightColor
                          : Theme.primaryColor))

                opacity: 0
            }

            BusyIndicator {
                size: BusyIndicatorSize.Medium
                anchors.centerIn: cover
                running: coverImage.status === Image.Loading
            }
        }

        Label {
            id: title

            Layout.fillWidth: true
            Layout.fillHeight: true

            text: model.title ? model.title : qsTr("Loading...")

            color: element.highlighted ? Theme.highlightColor : Theme.primaryColor
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: Theme.fontSizeLarge
            elide: Text.ElideRight
        }

        Text {
            id: episodesCount

            width: 100

            text: model.episodesCount

            color: element.highlighted ? Theme.highlightColor : Theme.primaryColor
        }
    }
}
