1.
Find the movie with the highest rating.
SQL: 
SELECT m.title, AVG(rating) AS avg_rating
FROM movies m
INNER JOIN u2base u ON m.movie_id = u.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC, m.title
LIMIT 1;

Cypher: 
MATCH (m:Movie)<-[r:RATED]-(:User) 
RETURN m.title AS title, AVG(r.rating) AS avg_rating 
ORDER BY AVG(r.rating) DESC, title
LIMIT 1;

2.
Find the user who has rated the most movies.
SQL:
SELECT u.*, COUNT(u2b.movie_id) AS movie_count 
FROM users u INNER JOIN u2base u2b ON u.user_id = u2b.user_id
GROUP BY u.user_id
ORDER BY movie_count DESC 
LIMIT 1;

Cypher: 
MATCH (u:User)-[:RATED]->(m:Movie)
RETURN u, COUNT(m) AS movie_count
ORDER BY movie_count DESC
LIMIT 1;

3.
Get all movies that have been rated by users who follow each other.
SQL:
SELECT DISTINCT m.title
FROM movies m
INNER JOIN u2base u ON m.movie_id = u.movie_id
INNER JOIN follow f1 ON u.user_id = f1.following
INNER JOIN follow f2 ON u.user_id = f2.user
INNER JOIN u2base u2 ON f1.user = u2.user_id AND f2.following = u2.user_id AND u.movie_id = u2.movie_id
WHERE u.user_id <> u2.user_id
ORDER BY m.title;

Cypher:
MATCH (u1:User)-[:FOLLOWS]->(u2:User), (u1)-[r1:RATED]->(m:Movie)<-[r2:RATED]-(u2)
WHERE u1 <> u2 AND EXISTS((u2)-[:FOLLOWS]->(u1))
RETURN DISTINCT m.title AS title
ORDER BY title;


4.
Find the user who has rated the most movies directed by the director with the id 98630.
SQL:
SELECT users.user_id, COUNT(*) AS directed_movies_count
FROM u2base
INNER JOIN users ON u2base.user_id = users.user_id
INNER JOIN movies2directors ON u2base.movie_id = movies2directors.movie_id
INNER JOIN directors ON movies2directors.director_id = directors.director_id
WHERE directors.director_id = 98630
GROUP BY users.user_id
ORDER BY directed_movies_count DESC, users.user_id
LIMIT 1;

Cypher:
MATCH (u:User)-[:RATED]->(m:Movie)-[:DIRECTED_BY]->(d:Director)
WHERE d.directorId = 98630
WITH u, count(m) AS directed_movies_count
RETURN u.userId AS userId, directed_movies_count
ORDER BY directed_movies_count DESC, userId
LIMIT 1;

5.
Find the average rating for each movie in English.
SQL:
SELECT m.title, AVG(u2b.rating) AS avg_rating
FROM movies m
INNER JOIN movies2actors m2a ON m.movie_id = m2a.movie_id
INNER JOIN movies2directors m2d ON m.movie_id = m2d.movie_id
INNER JOIN u2base u2b ON m.movie_id = u2b.movie_id
WHERE m.is_english = 'T'
GROUP BY m.title;

Cypher:
MATCH (m:Movie {isEnglish: 'T'})<-[r:RATED]-(:User)
WITH m, avg(r.rating) as avg_rating
RETURN m.title, avg_rating;

6.
Retrieve all movies released in a specific year, along with their directors and actors.
SQL:
SELECT DISTINCT m.title, d.director_id, a.actor_id
FROM movies m
JOIN movies2directors md ON m.movie_id = md.movie_id
JOIN directors d ON md.director_id = d.director_id
JOIN movies2actors ma ON m.movie_id = ma.movie_id
JOIN actors a ON ma.actor_id = a.actor_id
WHERE m.year = 1998;

SELECT m.title, 
       GROUP_CONCAT(DISTINCT d.director_id) AS directors, 
       GROUP_CONCAT(DISTINCT a.actor_id) AS artists
FROM movies m 
INNER JOIN movies2actors ma ON m.movie_id = ma.movie_id 
INNER JOIN actors a ON ma.actor_id = a.actor_id 
INNER JOIN movies2directors md ON m.movie_id = md.movie_id 
INNER JOIN directors d ON md.director_id = d.director_id 
WHERE m.year = 1998 
GROUP BY m.title
ORDER BY m.title;

Cypher:
MATCH (a:Actor)-[:ACTED_IN]->(m:Movie {year: 1998})-[:DIRECTED_BY]->(d:Director)
WITH a, m, d
ORDER BY a.actorId
WITH m.title AS title, collect(DISTINCT d.directorId) AS directors, collect(DISTINCT a.actorId) AS artists
RETURN title, directors, artists
ORDER BY title;

7.
Find the directors who are most popular among users who have rated at least 5 movies.
SQL:
SELECT d.director_id, COUNT(DISTINCT ur.user_id) AS num_users
FROM directors d
INNER JOIN movies2directors md ON d.director_id = md.director_id
INNER JOIN movies m ON md.movie_id = m.movie_id
INNER JOIN u2base ur ON m.movie_id = ur.movie_id
GROUP BY d.director_id
HAVING COUNT(DISTINCT ur.user_id) >= 5
ORDER BY num_users DESC
LIMIT 10;

Cypher:
MATCH (d:Director)<-[:DIRECTED_BY]-(movie)<-[:RATED]-(u:User)
WITH d, COUNT(DISTINCT u.userId) AS num_users
WHERE num_users >= 5
RETURN d.directorId AS director_id, num_users
ORDER BY num_users DESC
LIMIT 10;

8.
Retrieve all the users who are aged between 18 and 25 and have given a rating of 5 to any movie.
SQL: 
SELECT DISTINCT u.* 
FROM users u 
INNER JOIN u2base u2b ON u.user_id = u2b.user_id 
WHERE u.age BETWEEN 18 AND 25 AND u2b.rating = 5;

Cypher: 
MATCH (u:User)-[r:RATED {rating: 5}]->(m:Movie)
WHERE u.age >= 18 AND u.age <= 25
RETURN DISTINCT u;


9.
Retrieve all movies with the word "love" in the title and at least one rating of at least 4.
SQL:
SELECT DISTINCT m.title
FROM movies m
INNER JOIN u2base r ON m.movie_id = r.movie_id
WHERE title LIKE '%love%' AND rating >= 4;

Cypher:
MATCH (m:Movie)<-[r:RATED]-(:User)
WHERE toLower(m.title) CONTAINS 'love' and r.rating >= 4
RETURN distinct m.title;

10.
Find all the movies that have been noted by users who follow a specific user.
SQL:
SELECT DISTINCT movies.title, follow.user
FROM movies INNER JOIN u2base ON movies.movie_id = u2base.movie_id
INNER JOIN follow ON u2base.user_id = follow.user
WHERE follow.following = 123
ORDER BY movies.title, follow.user;

Cypher:
MATCH (u:User {userId: 123})<-[:FOLLOWS]-(u2:User)-[:RATED]->(m:Movie)
RETURN DISTINCT m.title AS title, u2.userId AS user
ORDER BY title, user;


Option.
Find the shortest path between the actor with the id 495111 and the actor with the id 496749.
Cypher:
MATCH p=shortestPath((a1:Actor)-[*1..5]-(a2:Actor))
WHERE a1.actorId = 495110 AND a2.actorId = 496749
RETURN p