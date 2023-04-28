--Create tables 
CREATE TABLE thirdNF_pokedex (
    pokedex_number INTEGER PRIMARY KEY,
    name TEXT,
    type1 TEXT,
    type2 TEXT,
    hidden_ability TEXT
);

CREATE TABLE thirdNF_abilities (
    ability_id INTEGER PRIMARY KEY,
    ability TEXT
);

CREATE TABLE thirdNF_pokemon_abilities (
    pokedex_number INTEGER,
    ability_id INTEGER,
    FOREIGN KEY (pokedex_number) REFERENCES pokemon(pokedex_number),
    FOREIGN KEY (ability_id) REFERENCES abilities(ability_id)
);

-- Insert data into tables
-- Insert into pokedex table
INSERT INTO thirdNF_pokedex (pokedex_number, name, type1, type2)
SELECT pokedex_number, name, type1, type2
FROM imported_pokemon_data;

-- Split thirdNF_abilities column and insert into abilities and pokemon_abilities tables
WITH split_abilities AS (
    SELECT pokedex_number, trim(ability) AS ability
    FROM imported_pokemon_data,
         json_each('["' || replace(thirdNF_abilities, ',', '","') || '"]')
    WHERE ability <> ''
)
INSERT INTO thirdNF_abilities (ability)
SELECT DISTINCT ability
FROM split_abilities
ORDER BY ability;

INSERT INTO thirdNF_pokemon_abilities (pokedex_number, ability_id)
SELECT pokedex_number, ability_id
FROM split_abilities
JOIN abilities ON split_abilities.ability = abilities.ability;
-- Insert into against_types table
CREATE TABLE thirdNF_against_types (
    pokedex_number INTEGER,
    type TEXT,
    damage_factor REAL,
    FOREIGN KEY (pokedex_number) REFERENCES pokemon(pokedex_number)
);

--Take out pokedex_number and just include type & damage factor.
INSERT INTO thirdNF_against_types (pokedex_number, type, damage_factor)
SELECT pokedex_number, 'normal', against_normal
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'fire', against_fire
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'water', against_water
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'electric', against_electric
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'grass', against_grass
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'ice', against_ice
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'poison', against_poison
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'ground', against_ground
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'flying', against_flying
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'psychic', against_psychic
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'bug', against_bug
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'rock', against_rock
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'ghost', against_ghost
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'dragon', against_dragon
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'dark', against_dark
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'steel', against_steel
FROM imported_pokemon_data
UNION ALL
SELECT pokedex_number, 'fairy', against_fairy
FROM imported_pokemon_data;

-- Create the types table
CREATE TABLE secondNF_types (
  id INTEGER PRIMARY KEY,
  type_name TEXT NOT NULL,
  UNIQUE(type_name)
);

-- Create the pokemontypes table to represent the many-to-many relationship between Pokemon and Types
CREATE TABLE secondNF_pokemontypes (
  pokedex_number INTEGER NOT NULL,
  type_id INTEGER NOT NULL,
  PRIMARY KEY (pokedex_number, type_id),
  FOREIGN KEY (pokedex_number) REFERENCES Pokemon(pokedex_number) ON DELETE CASCADE,
  FOREIGN KEY (type_id) REFERENCES Types(id) ON DELETE CASCADE
);

-- Insert data into the types table
INSERT INTO secondNF_types (type_name)
SELECT DISTINCT type
FROM (
  SELECT type1 AS type FROM imported_pokemon_data
  UNION
  SELECT type2 AS type FROM imported_pokemon_data
) AS types;

-- Insert data into the PokemonTypes table
INSERT INTO secondNF_pokemontypes (pokedex_number, type_id)
SELECT pokedex_number, types_id
FROM imported_pokemon_data
JOIN types ON imported_pokemon_data.type1 = Types.type_name OR imported_pokemon_data.type2 = Types.type_name;