/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0

/**
 * Pure data object that represents search results.
 */
QtObject {

    /**
     * Query string that was used to fetch results.
     */
    property string query: ""

    /**
     * Query status
     */
    property int status: Component.Null

    /**
     * If `status` becomes Component.Error, the `error` property holds error description string.
     */
    property string error: ""

    /**
     * List of `Station` objects returned by query.
     */
    property var stations: []

    /**
     * List of `Episode` objects returned by query.
     */
    property var episodes: []
}
