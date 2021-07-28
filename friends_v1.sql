SELECT *
FROM users;

SELECT * 
FROM friendships;

SELECT users.first_name, users.last_name, user2.first_name as friend_first_name, user2.last_name as friend_last_name
FROM friendships
LEFT JOIN users ON friendships.user_id = users.id 
LEFT JOIN users as user2 ON friendships.friend_id = user2.id;

-- 1-Devuelva a todos los usuarios que son amigos de Kermit, asegúrese de que sus nombres se muestren en los resultados.

SELECT users.first_name, users.last_name, user2.first_name as friend_first_name, user2.last_name as friend_last_name
FROM friendships
LEFT JOIN users ON friendships.user_id = users.id 
LEFT JOIN users as user2 ON friendships.friend_id = user2.id
WHERE user2.first_name = 'Kermit';


-- 2-Devuelve el recuento de todas las amistades.

SELECT COUNT(friendships.id)
FROM friendships
LEFT JOIN users ON friendships.user_id = users.id 
LEFT JOIN users as user2 ON friendships.friend_id = user2.id;


-- 3-Descubre quién tiene más amigos y devuelve el recuento de sus amigos.

SELECT users.first_name, users.last_name, COUNT(user2.first_name) as Amigos
FROM friendships
LEFT JOIN users ON friendships.user_id = users.id 
LEFT JOIN users as user2 ON friendships.friend_id = user2.id
GROUP BY users.first_name, users.last_name;


-- 4-Crea un nuevo usuario y hazlos amigos de Eli Byers, Kermit The Frog y Marky Mark.

SELECT id
FROM users;
INSERT INTO users (id, first_name, last_name, created_at, updated_at)
VALUES ('7', 'Jimmy', 'Duarte', NOW(), NOW());

SELECT *
FROM friendships;
INSERT INTO friendships (id, user_id, friend_id, created_at)
VALUES ('7', '7', '2', NOW());

INSERT INTO friendships (id, user_id, friend_id, created_at)
VALUES ('8', '7', '4', NOW());

INSERT INTO friendships (id, user_id, friend_id, created_at)
VALUES ('9', '7', '5', NOW());


-- 5-Devuelve a los amigos de Eli en orden alfabético.

SELECT users.first_name, users.last_name, user2.first_name as friend_first_name, user2.last_name as friend_last_name
FROM friendships
LEFT JOIN users ON friendships.user_id = users.id 
LEFT JOIN users as user2 ON friendships.friend_id = user2.id
WHERE users.first_name = 'Eli'
ORDER BY friend_first_name ASC;

-- 6-Eliminar a Marky Mark de los amigos de Eli.

SELECT users.first_name, users.last_name, user2.first_name as friend_first_name, user2.last_name as friend_last_name
FROM friendships
LEFT JOIN users ON friendships.user_id = users.id 
LEFT JOIN users as user2 ON friendships.friend_id = user2.id;

SELECT * FROM friendships;
SELECT * FROM users;

DELETE FROM friendships
WHERE id = '5' AND friend_id ='5';

-- 7-Devuelve todas las amistades, mostrando solo el nombre y apellido de ambos amigos

SELECT users.first_name, users.last_name, user2.first_name as friend_first_name, user2.last_name as friend_last_name
FROM friendships
LEFT JOIN users ON friendships.user_id = users.id 
LEFT JOIN users as user2 ON friendships.friend_id = user2.id;




