CREATE TABLE devices (
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT NOW()
);

CREATE TABLE parts (
  id serial PRIMARY Key,
  part_number integer UNIQUE NOT NULL,
  device_id integer REFERENCES devices (id)
);