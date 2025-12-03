CREATE TABLE actors (
    actor_id INT NOT NULL PRIMARY KEY,
    a_gender VARCHAR(2) NOT NULL,
    a_quality INT NOT NULL
);

CREATE TABLE directors (
    director_id INT NOT NULL PRIMARY KEY,
    d_quality INT NOT NULL,
    avg_revenue INT NOT NULL
);

CREATE TABLE movies (
    movie_id INT NOT NULL PRIMARY KEY,
    is_english VARCHAR(2) NOT NULL,
    country VARCHAR(10) NOT NULL,
    running_time INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    year INT NOT NULL
);

CREATE TABLE users (
    user_id INT NOT NULL PRIMARY KEY,
    age INT NOT NULL,
    u_gender VARCHAR(2) NOT NULL,
    occupation INT NOT NULL
);

CREATE TABLE movies2actors (
    movie_id INT NOT NULL,
    actor_id INT NOT NULL,
    cast_num INT NOT NULL,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id) 
);

CREATE TABLE movies2directors (
    movie_id INT NOT NULL,
    director_id INT NOT NULL,
    genre VARCHAR(20) NOT NULL,
    PRIMARY KEY (movie_id, director_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (director_id) REFERENCES director(director_id)
);

CREATE TABLE u2base (
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    rating INT NOT NULL,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

CREATE TABLE follow (
    user INT NOT NULL,
    following INT NOT NULL,
    PRIMARY KEY (user, following),
    FOREIGN KEY (user) REFERENCES users(user_id),
    FOREIGN KEY (following) REFERENCES users(user_id)
);

CREATE INDEX idx_movies_id ON movies(movie_id);
CREATE INDEX idx_actors_id ON actors(actor_id);
CREATE INDEX idx_directors_id ON directors(director_id);
CREATE INDEX idx_users_id ON users(user_id);
CREATE INDEX idx_movies2actors_ids ON movies2actors(movie_id, actor_id);
CREATE INDEX idx_movies2directors_ids ON movies2directors(movie_id, director_id);
CREATE INDEX idx_u2base_ids ON u2base(user_id, movie_id);
CREATE INDEX idx_follow_ids ON follow(user, following);

LOAD DATA LOCAL INFILE 'C:/Users/nathan/OneDrive/Bureau/Master/BDA+/Projet/actors.csv' 
INTO TABLE actors 
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(actor_id, a_gender, a_quality);

LOAD DATA LOCAL INFILE 'C:/Users/nathan/OneDrive/Bureau/Master/BDA+/Projet/directors.csv' 
INTO TABLE directors 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(director_id, d_quality, avg_revenue);

LOAD DATA LOCAL INFILE 'C:/Users/nathan/OneDrive/Bureau/Master/BDA+/Projet/movies.csv' 
INTO TABLE movies 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(movie_id, is_english, country, running_time, title, year);

LOAD DATA LOCAL INFILE 'C:/Users/nathan/OneDrive/Bureau/Master/BDA+/Projet/users.csv' 
INTO TABLE users 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(user_id, age, u_gender, occupation);

LOAD DATA LOCAL INFILE 'C:/Users/nathan/OneDrive/Bureau/Master/BDA+/Projet/movies2actors.csv' 
INTO TABLE movies2actors 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(movie_id, actor_id, cast_num);

LOAD DATA LOCAL INFILE 'C:/Users/nathan/OneDrive/Bureau/Master/BDA+/Projet/movies2directors.csv' 
INTO TABLE movies2directors 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(movie_id, director_id, genre);

LOAD DATA LOCAL INFILE 'C:/Users/nathan/OneDrive/Bureau/Master/BDA+/Projet/u2base.csv' 
INTO TABLE u2base 
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(user_id, movie_id, rating);

LOAD DATA LOCAL INFILE 'C:/Users/nathan/OneDrive/Bureau/Master/BDA+/Projet/follow.csv' 
INTO TABLE follow 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(user, following);