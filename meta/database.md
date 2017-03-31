# database structure for Sailcast

## conventions

relations between tables in database expressed using the following notation:

- `field => other_table`: `field` reffers `other_table.<ot>_id` field, where `<ot>` is the `other_table`'s prefix
- '=>': many-to-one
- '<->': one-to-one
- '<=>': many-to-many

## tables

### station, prefix: 'st'

- id PRIMARY KEY
- name TEXT
- description TEXT, HTML-formatted
- cover => cover, image URL
- feed_url TEXT, RSS URL

### episode, prefix: 'ep'

- id PRIMARY KEY
- station => station
- title TEXT
- description TEXT, HTML-formatted
- duration INT, seconds
- guid TEXT
- cover => cover
- date TEXT, ISO 8601 encoded publication date
- url TEXT
- playback-related fields:
	- playback_position INT DEFAULT 0, for how many seconds user listened this episode
	- playback_status INT DEFAULT 0, where 0 for never played, 1 for partial and 2 for finished 


### subscription, prefix: 'sb'

- station PRIMARY KEY <-> station
- active INT, 1/0 indicates whether to fetch new episodes automatically when application starts
- priority INT, unique priority, lets user rearrange subscriptions

### cover, prefix: 'cv'

- id PRIMARY KEY

### cover_size, prefix: 'cs'

- id PRIMARY KEY
- cover => cover
- width INT
- height INT
- url TEXT, remote URL

### genres, prefix: 'gn'

- genre_id INT, fixed set of genres hardcored into the application
- station <=> station, each station may conform to more than one genre

## future extensions

### cover_cache

- cover_size PRIMARY KEY <-> cover_size
- uri TEXT, local file path
