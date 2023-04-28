-- Create the pokedex table
CREATE TABLE secondNF_pokedex (
  pokedex_number INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  type1 TEXT NOT NULL,
  type2 TEXT,
  hp INTEGER,
  attack INTEGER,
  defense INTEGER,
  sp_attack INTEGER,
  sp_defense INTEGER,
  speed INTEGER,
  UNIQUE(name)
);

-- Insert data into the pokedex table
INSERT INTO secondNF_pokedex (pokedex_number, name, type1, type2, hp, attack, defense, sp_attack, sp_defense, speed)
SELECT pokedex_number, name, type1, type2, hp, attack, defense, sp_attack, sp_defense, speed
FROM imported_pokemon_data;

-- Create the stats table
CREATE TABLE secondNF_stats (
  id INTEGER PRIMARY KEY,
  stat_name TEXT NOT NULL,
  UNIQUE(stat_name)
);

-- Create the pokemonstats table to represent the many-to-many relationship between Pokemon and Stats
CREATE TABLE secondNF_pokemonstats (
  pokedex_number INTEGER NOT NULL,
  stat_id INTEGER NOT NULL,
  base_stat INTEGER NOT NULL,
  PRIMARY KEY (pokedex_number, stat_id),
  FOREIGN KEY (pokedex_number) REFERENCES Pokemon(pokedex_number) ON DELETE CASCADE,
  FOREIGN KEY (stat_id) REFERENCES Stats(id) ON DELETE CASCADE
);


-- Insert data into the stats table
INSERT INTO secondNF_stats (stat_name)
VALUES ('hp'), ('attack'), ('defense'), ('sp_attack'), ('sp_defense'), ('speed');


-- Insert data into the pokemonstats table
INSERT INTO secondNF_pokemonstats (pokedex_number, stat_id, base_stat)
SELECT pokedex_number, Stats.id, hp
FROM imported_pokemon_data
JOIN secondNF_stats ON Stats.stat_name = 'hp'
UNION ALL
SELECT pokedex_number, Stats.id, attack
FROM imported_pokemon_data
JOIN secondNF_stats ON Stats.stat_name = 'attack'
UNION ALL
SELECT pokedex_number, Stats.id, defense
FROM imported_pokemon_data
JOIN secondNF_stats ON Stats.stat_name = 'defense'
UNION ALL
SELECT pokedex_number, Stats.id, sp_attack
FROM imported_pokemon_data
JOIN secondNF_stats ON Stats.stat_name = 'sp_attack'
UNION ALL
SELECT pokedex_number, Stats.id, sp_defense
FROM imported_pokemon_data
JOIN secondNF_stats ON Stats.stat_name = 'sp_defense'
UNION ALL
SELECT pokedex_number, Stats.id, speed
FROM imported_pokemon_data
JOIN secondNF_stats ON Stats.stat_name = 'speed';

--Create the against table
CREATE TABLE secondNF_against (
 pokedex_number INTEGER,
 against_type TEXT,
 against_value REAL,
 PRIMARY KEY (pokedex_number, against_type)
);

--Insert data into the against table
INSERT INTO secondNF_against (pokedex_number, against_type, against_value)
SELECT pokedex_number, 'against_bug', against_bug FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_dark', against_dark FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_dragon', against_dragon FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_electric', against_electric FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_fairy', against_fairy FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_fight', against_fight FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_fire', against_fire FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_flying', against_flying FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_ghost', against_ghost FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_grass', against_grass FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_ground', against_ground FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_ice', against_ice FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_normal', against_normal FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_poison', against_poison FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_psychic', against_psychic FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_rock', against_rock FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_steel', against_steel FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'against_water', against_water FROM imported_pokemon_data;
