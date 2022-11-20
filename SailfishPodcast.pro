# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = SailfishPodcast

CONFIG += sailfishapp

SOURCES += src/SailfishPodcast.cpp

OTHER_FILES += qml/SailfishPodcast.qml \
    qml/cover/CoverPage.qml \
    rpm/SailfishPodcast.changes.in \
    rpm/SailfishPodcast.spec \
    rpm/SailfishPodcast.yaml \
    translations/*.ts \
    SailfishPodcast.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/SailfishPodcast-ru.ts

DISTFILES += \
    qml/pages/StationPage.qml \
    qml/model/Station.qml \
    qml/service/Dao.qml \
    qml/pages/SearchPage.qml \
    qml/service/qmldir \
    qml/view/StationListElement.qml \
    qml/model/Episode.qml \
    qml/view/EpisodeListElement.qml \
    qml/view/StationHeader.qml \
    icons/108x108/SailfishPodcast.png \
    icons/128x128/SailfishPodcast.png \
    icons/172x172/SailfishPodcast.png \
    icons/256x256/SailfishPodcast.png \
    icons/86x86/SailfishPodcast.png \
    meta/database.md \
    meta/schema.sql \
    rpm/SailfishPodcast.spec \
    qml/view/StationsListView.qml \
    qml/model/SubscriptionsListModel.qml \
    qml/pages/SubscriptionsPage.qml \
    qml/model/StationsListModel.qml \
    qml/view/EpisodesListView.qml \
    qml/model/EpisodesListModel.qml \
    qml/model/SearchResult.qml \
    qml/service/ITunes.qml \
    qml/view/CoverView.qml
