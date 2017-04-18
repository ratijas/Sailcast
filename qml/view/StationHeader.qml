import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    Row{
        x: Theme.paddingLarge
        y: Theme.paddingLarge
        height: 200
        width: parent.width
        Image {
            id:stationCover
            source: "http://www.radio-t.com/images/cover.jpg"
            width: parent.height
            height:parent.height
        }
        Column{
            height:parent.height
            width: parent.width-stationCover.width-2*Theme.paddingLarge
            //width: 400
            Label {
                id:stationLabel
                x: Theme.horizontalPageMargin
                text: qsTr("Радио-Т")
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.primaryColor
            }
            TextArea {
                text: qsTr(" Еженедельные импровизации на хай–тек темы Еженедельные импровизации на хай–тек темы")
                color: Theme.primaryColor
                //width: parent.width-station.width- 3*Theme.horizontalPageMargin
                width: parent.width
                height:parent.height
                readOnly:true
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: TextEdit.WordWrap
            }
        }
    }
}
