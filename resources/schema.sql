CREATE TABLE IF NOT EXISTS users (
    id serial PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO users(name) VALUES('Damian'),('Pablo');