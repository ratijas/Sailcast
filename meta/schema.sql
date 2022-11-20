CREATE TABLE IF NOT EXISTS subscription(
	sb_station INTEGER PRIMARY KEY NOT NULL,
	sb_active INTEGER NOT NULL,
	sb_priority INTEGER NOT NULL,
	CONSTRAINT priority_unique UNIQUE (sb_priority)
);

CREATE TABLE IF NOT EXISTS station(
	st_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	st_name TEXT NOT NULL,
	st_description TEXT,
	st_cover INTEGER,
	st_feed_url TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS episode(
	ep_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	ep_station INTEGER NOT NULL,
	ep_title TEXT NOT NULL,
	ep_description TEXT,
	ep_duration INTEGER NOT NULL,
	ep_guid TEXT,
	ep_cover INTEGER,
	ep_date TEXT NOT NULL,
	ep_url TEXT NOT NULL,
	ep_playback_position INTEGER NOT NULL DEFAULT 0,
	ep_playback_status INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS cover(
	cv_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
);

CREATE TABLE IF NOT EXISTS cover_size(
	cs_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	cs_cover INTEGER NOT NULL,
	cs_width INTEGER NOT NULL,
	cs_height INTEGER NOT NULL,
	CONSTRAINT unique_size UNIQUE (
		cs_cover,
		cs_width,
		cs_height
	) ON CONFLICT REPLACE
);

CREATE TABLE IF NOT EXISTS genres(
	gn_genre_id INTEGER NOT NULL,
	gn_station INTEGER NOT NULL
);