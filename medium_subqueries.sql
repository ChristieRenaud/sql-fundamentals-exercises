CREATE TABLE bidders (
  id serial PRIMARY KEY,
  name text NOT NULL 
);

CREATE TABLE items (
 id serial PRIMARY KEY,
 name text NOT NULL,
 initial_price numeric(6,2) NOT NULL CHECK(initial_price BETWEEN 0.01 AND 1000.00),
 sales_price numeric(6,2) CHECK(sales_price BETWEEN 0.01 AND 1000.00)
);



CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount numeric(6, 2) NOT NULL CHECK (amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX ON bids (bidder_id, item_id);

\copy bidders from './SQL_fundamentals_exercises/bidders.csv' with HEADER CSV;

\copy items from './SQL_fundamentals_exercises/items.csv' with HEADER CSV;

\copy bids from './SQL_fundamentals_exercises/bids.csv' with HEADER CSV;

SELECT name as "Bid on Items" FROM items WHERE items.id IN
  (SELECT DISTINCT item_id FROM bids);

SELECT name as "Not Bid On" FROM items 
WHERE items.id NOT IN (SELECT item_id FROM bids);

SELECT name FROM bidders WHERE EXISTS 
  (SELECT 1 FROM bids
    WHERE bids.bidder_id = bidders.id);

SELECT DISTINCT name FROM bidders JOIN bids ON bidders.id = bids.bidder_id;

SELECT name as "Bids Less Than 100 Dollars" FROM items WHERE items.id = ANY 
  (SELECT item_id FROM bids WHERE amount < 100.00 );

SELECT name as "Bids Less Than 100 Dollars" FROM items WHERE 100.00 > ANY
  (SELECT amount FROM bids WHERE item_id = items.id);

SELECT max(bid_counts.count) FROM
  (SELECT count(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

SELECT name, (SELECT count(bids.item_id) FROM bids WHERE bids.item_id = items.id)
  FROM items;

SELECT items.name AS name, count(bids.item_id) FROM items LEFT OUTER JOIN bids 
  ON items.id = bids.item_id
  GROUP BY items.name;