CREATE TABLE trainer (
  id INTEGER PRIMARY KEY,
  first_name TEXT(80),
  last_name TEXT(80)
);

CREATE TABLE favorite_pokemon_type (
  id INTEGER PRIMARY KEY,
  type_name TEXT(80)
);

CREATE TABLE pokemon_team (
  id INTEGER PRIMARY KEY,
  trainer_id INTEGER,
  pokemon_id INTEGER,
  FOREIGN KEY (trainer_id) REFERENCES trainer(id),
  FOREIGN KEY (pokemon_id) REFERENCES pokemon(id)
);

INSERT INTO trainer (first_name, last_name) VALUES
  ('Ted’, 'Neward'),
  (‘Justin', 'Dong'),
  ('Jenny', 'Suk'),
  ('Kunal', 'Anand');

INSERT INTO favorite_pokemon_type (type_name) VALUES
  ('Electric'),
  ('Fire'),
  ('Water'),
  ('Grass'),
  ('Psychic');

INSERT INTO pokemon_team (trainer_id, pokemon_id) VALUES
  (1, 3),
  (1, 6),
  (1, 9),
  (1, 25),
  (2, 1),
  (2, 4),
  (2, 7),
  (2, 10),
  (3, 2),
  (3, 5),
  (3, 8),
  (3, 11),
  (4, 13),
  (4, 15),
  (4, 17),
  (4, 19);


