CREATE TABLE devices (
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE parts (
id serial PRIMARY KEY,
part_number integer UNIQUE NOT NULL,
device_id integer REFERENCES devices (id)
);

INSERT INTO devices (name) VALUES ('Accelerometer'), ('Gyroscope');
INSERT INTO parts (part_number, device_id)
     VALUES (100, 1), (101, 1), (102, 1), (103, 2), (104, 2), (105, 2), (106, 2), (107, 2);
INSERT INTO parts (part_number) VALUES (108), (109), (110); 

SELECT name, part_number FROM devices
INNER JOIN parts on devices.id = parts.device_id;

SELECT * FROM parts
WHERE part_number::text LIKE '3%';

SELECT devices.name, count(parts.device_id) AS number_of_parts
FROM devices INNER JOIN parts on devices.id = parts.device_id
GROUP BY devices.name
ORDER BY devices.name ASC;

SELECT parts.part_number, parts.device_id FROM parts
WHERE device_id IS NULL;

SELECT name FROM devices
ORDER BY created_at ASC
LIMIT 1;

UPDATE parts SET device_id = 1
WHERE part_number = 106 OR part_number = 107;

SELECT min(part_number) FROM parts;
UPDATE parts SET device_id=3
WHERE part_number = 100;

DELETE FROM parts
WHERE device_id = 1;

DELETE FROM devices
WHERE name = 'Accelerometer';