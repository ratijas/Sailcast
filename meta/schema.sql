CREATE TABLE IF NOT EXIST subscription (
	sb_station INT PRIMARY KEY NOT NULL,
	sb_active INT NOT NULL,
	sb_priority INT NOT NULL,
	CONSTRAINT priority_unique UNIQUE (sb_priority)
);

CREATE TABLE IF NOT EXIST station (
	st_id INT PRIMARY KEY NOT NULL AUTOINCREMENT,
	st_name TEXT NOT NULL,
	st_description TEXT,
	st_cover INT,
	st_feed_url TEXT NOT NULL
);

CREATE TABLE IF NOT EXIST episode (
	ep_id INT PRIMARY KEY NOT NULL AUTOINCREMENT,
	ep_station INT NOT NULL,
	ep_title TEXT NOT NULL,
	ep_description TEXT,
	ep_duration INT NOT NULL,
	ep_guid TEXT,
	ep_cover INT,
	ep_date TEXT NOT NULL,
	ep_url TEXT NOT NULL,
	ep_playback_position INT NOT NULL DEFAULT 0,
	ep_playback_status INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXIST cover (
	cv_id INT PRIMARY KEY NOT NULL AUTOINCREMENT
);

CREATE TABLE IF NOT EXIST cover_size (
	cs_id INT PRIMARY KEY NOT NULL AUTOINCREMENT,
	cs_cover INT NOT NULL,
	cs_width INT NOT NULL,
	cs_height INT NOT NULL,
	CONSTRAINT unique_size UNIQUE (
		cs_cover,
		cs_width,
		cs_height
	) ON CONFLICT REPLACE
);

CREATE TABLE IF NOT EXIST genres (
	gn_genre_id INT NOT NULL,
	gn_station INT NOT NULL
);