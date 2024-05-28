-- name: CreateAccount :one
INSERT INTO account (owner,
                     balance,
                     currency)
VALUES ($1, $2, $3) RETURNING *;

-- name: GetAccount :one
SELECT *
FROM account
WHERE id = $1;

-- name: GetAccountForUpdate :one
SELECT *
FROM account
WHERE id = $1 FOR NO KEY
UPDATE;

-- name: ListAccounts :many
SELECT *
FROM account
ORDER BY id limit $1
offset $2;

-- name: UpdateAccount :one
UPDATE account
SET balance    = $2,
    last_update=now()
WHERE id = $1 RETURNING *;

-- name: AddAccountBalance :one
UPDATE account
SET balance    = balance + sqlc.arg(amout),
    last_update=now()
WHERE id = sqlc.arg(id) RETURNING *;

-- name: DeleteAccount :exec
DELETE
FROM account
WHERE id = $1;