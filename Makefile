postgres:
	docker run --name bank-postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=oraclE44 -d postgres:12-alpine

createdb:
	docker exec -it bank-postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it bank-postgres dropdb  simple_bank

migrationup:
	migrate -path db/migration -database "postgresql://root:oraclE44@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrationdown:
	yes | migrate -path db/migration -database "postgresql://root:oraclE44@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

.PHONEY: postgres createdb dropdb migrationup migrationdown sqlc test server