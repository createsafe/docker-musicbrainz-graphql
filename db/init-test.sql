
CREATE TABLE items(id SERIAL PRIMARY KEY, text VARCHAR(40), completed BOOLEAN);
INSERT INTO items(text, completed) VALUES('test', false);
