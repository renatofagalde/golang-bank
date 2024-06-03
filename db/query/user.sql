-- name: CreateUser :one
INSERT INTO "user" (
username,
hashed_password,
email,
full_name)
VALUES ($1, $2, $3,$4) RETURNING *;

-- name: GetUser :one
SELECT *
FROM "user"
WHERE username = $1 limit 1;
