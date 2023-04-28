CREATE TABLE firstNF_abilities (
    id INTEGER PRIMARY KEY,
    pokedex_number INTEGER,
    ability TEXT
);

INSERT INTO firstNF_abilities (pokedex_number, ability)
SELECT pokedex_number, trim(value) AS ability
FROM imported_pokemon_data
JOIN json_each('["' || replace(abilities, ',', '","') || '"]')
GROUP BY pokedex_number, ability;
